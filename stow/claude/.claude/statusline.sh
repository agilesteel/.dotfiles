#!/bin/bash
# Claude Code status line. Must stay compatible with macOS /bin/bash 3.2.
#
# Line 1: os user@host  model (effort) [fast]  dir  owner/repo  git (branch, status, +/- lines)  #PR state  "session name"
# Line 2: context bar %  5h % reset  7d % reset  cache %  $cost  ram  disk

# Read every field in one jq call. Missing fields become "".
eval "$(jq -r '
  def pct: if . == null then "" else floor end;
  @sh "MODEL=\(.model.display_name // "")",
  @sh "WORKSPACE=\(.workspace.current_dir // "")",
  @sh "EFFORT=\(.effort.level // "")",
  @sh "FAST=\(.fast_mode // false)",
  @sh "CTX_PCT=\(.context_window.used_percentage | if . == null then 0 else floor end)",
  @sh "H5_PCT=\(.rate_limits.five_hour.used_percentage | pct)",
  @sh "H5_RESET=\(.rate_limits.five_hour.resets_at // "")",
  @sh "D7_PCT=\(.rate_limits.seven_day.used_percentage | pct)",
  @sh "D7_RESET=\(.rate_limits.seven_day.resets_at // "")",
  @sh "PR_NUM=\(.pr.number // "")",
  @sh "PR_URL=\(.pr.url // "")",
  @sh "PR_STATE=\(.pr.review_state // "")",
  @sh "SESSION=\(.session_name // "")",
  @sh "CACHE_WARM=\(.prompt_cache.warm | if . == null then "" else tostring end)",
  @sh "CACHE_HIT=\(.prompt_cache.hit_ratio | if . == null then "" else (. * 100 | floor) end)",
  @sh "COST=\(.cost.total_cost_usd // 0)",
  @sh "REPO=\(.workspace.repo | if . == null then "" else "\(.owner)/\(.name)" end)",
  @sh "REPO_HOST=\(.workspace.repo.host // "")"
')"

ESC=$'\033'
RESET="${ESC}[0m"
fg() { printf '%s[38;5;%sm' "$ESC" "$1"; }

# green <= 50%, yellow <= 80%, red > 80%
pct_color() {
  if [ "$1" -le 50 ]; then printf '%s[0;32m' "$ESC"
  elif [ "$1" -le 80 ]; then printf '%s[0;33m' "$ESC"
  else printf '%s[0;31m' "$ESC"; fi
}

# Epoch seconds -> local time. GNU date first, BSD date as a fallback.
fmt_time() { date -d "@$1" "+$2" 2>/dev/null || date -r "$1" "+$2"; }

# ── line 1 ─────────────────────────────────────────────────────────

# OS icon + user@host, like the shell prompt (WSL shows the distro name)
case "$(uname -s)" in
  Darwin) OS_ICON=$'\xef\x85\xb9' ;;                                        # nf-fa-apple
  Linux)  if grep -q '^ID=ubuntu' /etc/os-release 2>/dev/null; then
            OS_ICON=$'\xef\x8c\x9b'                                          # nf-linux-ubuntu
          else
            OS_ICON=$'\xef\x85\xbc'                                          # nf-fa-linux
          fi ;;
  *)      OS_ICON="" ;;
esac
HOST="${WSL_DISTRO_NAME:-$(hostname -s)}"

LINE1="${OS_ICON:+${OS_ICON} }$(fg 180)${USER}@${HOST}${RESET} $(fg 39)${MODEL}${RESET}"
[ -n "$EFFORT" ] && LINE1+=" $(fg 66)(${EFFORT})${RESET}"
[ "$FAST" = "true" ] && LINE1+=" $(fg 178)⚡fast${RESET}"

# Directory like the shell prompt: ~-abbreviated, leaf in bold
if [ -n "$WORKSPACE" ]; then
  TILDE='~'  # a literal ~ in the replacement would be expanded back to $HOME
  DIR="${WORKSPACE/#$HOME/$TILDE}"
  LEAF="${DIR##*/}"
  PARENT="${DIR%"$LEAF"}"
  LINE1+=" $(fg 31)${PARENT}${ESC}[1;38;5;39m${LEAF}${RESET}"
fi

# owner/name from the origin remote
[ -n "$REPO" ] && LINE1+=" $(fg 66)${REPO}${RESET}"

# Git section, same look as the shell prompt (starship.toml):
#  branch ⇣1⇡2 *stash ~conflicted +staged !modified ?untracked +added -removed
# The +/- counts are the uncommitted diff (`git diff --shortstat`), like starship's git_metrics.
GIT_STATUS=$(git -C "$WORKSPACE" status --porcelain=v2 --branch 2>/dev/null)
if [ -n "$GIT_STATUS" ]; then
  GIT=""
  [ "$REPO_HOST" = "github.com" ] && GIT+="$(fg 76)"$'\xef\x84\x93'" "   # nf-fa-github_alt
  eval "$(printf '%s\n' "$GIT_STATUS" | awk '
    /^# branch.head / { head = $3 }
    /^# branch.ab /   { ahead = substr($3, 2); behind = substr($4, 2) }
    /^[12] /          { if (substr($2, 1, 1) != ".") staged++; if (substr($2, 2, 1) != ".") modified++ }
    /^u /             { conflicted++ }
    /^\? /            { untracked++ }
    END {
      printf "BRANCH=%s AHEAD=%d BEHIND=%d STAGED=%d MODIFIED=%d CONFLICTED=%d UNTRACKED=%d\n",
        head, ahead, behind, staged, modified, conflicted, untracked
    }')"
  STASHES=$(git -C "$WORKSPACE" rev-list --walk-reflogs --count refs/stash 2>/dev/null || echo 0)

  GIT+="$(fg 76)"$'\xef\x84\xa6'" ${BRANCH}"   # nf-fa-code_fork
  if [ "$BEHIND" -gt 0 ] || [ "$AHEAD" -gt 0 ]; then
    GIT+=" $(fg 76)"
    [ "$BEHIND" -gt 0 ] && GIT+="⇣${BEHIND}"
    [ "$AHEAD" -gt 0 ] && GIT+="⇡${AHEAD}"
  fi
  [ "$STASHES" -gt 0 ]    && GIT+=" $(fg 76)*${STASHES}"
  [ "$CONFLICTED" -gt 0 ] && GIT+=" $(fg 196)~${CONFLICTED}"
  [ "$STAGED" -gt 0 ]     && GIT+=" $(fg 178)+${STAGED}"
  [ "$MODIFIED" -gt 0 ]   && GIT+=" $(fg 178)!${MODIFIED}"
  [ "$UNTRACKED" -gt 0 ]  && GIT+=" $(fg 76)?${UNTRACKED}"
  # "3 files changed, 12 insertions(+), 4 deletions(-)"; either part may be missing
  SHORTSTAT=$(git -C "$WORKSPACE" diff --shortstat 2>/dev/null)
  ADDED=$(printf '%s' "$SHORTSTAT" | sed -n 's/.* \([0-9][0-9]*\) insertion.*/\1/p')
  REMOVED=$(printf '%s' "$SHORTSTAT" | sed -n 's/.* \([0-9][0-9]*\) deletion.*/\1/p')
  [ "${ADDED:-0}" -gt 0 ]   && GIT+=" $(fg 76)+${ADDED}"
  [ "${REMOVED:-0}" -gt 0 ] && GIT+=" $(fg 196)-${REMOVED}"
  LINE1+=" ${GIT}${RESET}"
fi

# PR number as a clickable link (OSC 8), plus review state
if [ -n "$PR_NUM" ]; then
  case "$PR_STATE" in
    approved)          STATE=" $(fg 76)✓" ;;
    changes_requested) STATE=" $(fg 196)✗" ;;
    pending)           STATE=" $(fg 178)●" ;;
    draft)             STATE=" $(fg 244)draft" ;;
    *)                 STATE="" ;;
  esac
  LINE1+=" $(fg 32)${ESC}]8;;${PR_URL}${ESC}\\#${PR_NUM}${ESC}]8;;${ESC}\\${STATE}${RESET}"
fi

[ -n "$SESSION" ] && LINE1+=" $(fg 180)\"${SESSION}\"${RESET}"

# ── line 2 ─────────────────────────────────────────────────────────

# Fira Code progress bar glyphs (Private Use Area)
# U+EE00/EE01/EE02: left cap / middle / right cap, empty
# U+EE03/EE04/EE05: left cap / middle / right cap, filled
# Written as raw UTF-8 bytes: macOS /bin/bash is 3.2, which predates $'\u' (bash 4.2+)
LEFT_EMPTY=$'\xee\xb8\x80'
MID_EMPTY=$'\xee\xb8\x81'
RIGHT_EMPTY=$'\xee\xb8\x82'
LEFT_FILLED=$'\xee\xb8\x83'
MID_FILLED=$'\xee\xb8\x84'
RIGHT_FILLED=$'\xee\xb8\x85'

# Colored bar + percentage: bar <pct> <width> (width includes both caps)
bar() {
  local pct=$1 width=$2 filled out="" i
  filled=$(( pct * width / 100 ))
  for (( i=0; i<width; i++ )); do
    if [ "$i" -lt "$filled" ]; then
      if [ "$i" -eq 0 ]; then out+="$LEFT_FILLED"
      elif [ "$i" -eq $(( width - 1 )) ]; then out+="$RIGHT_FILLED"
      else out+="$MID_FILLED"; fi
    else
      if [ "$i" -eq 0 ]; then out+="$LEFT_EMPTY"
      elif [ "$i" -eq $(( width - 1 )) ]; then out+="$RIGHT_EMPTY"
      else out+="$MID_EMPTY"; fi
    fi
  done
  printf '%s%s %s%%%s' "$(pct_color "$pct")" "$out" "$pct" "$RESET"
}

# Context label: nf-fae-brain (U+E28C) as raw UTF-8 bytes, like the bar glyphs
CTX_ICON=$'\xee\x8a\x8c'
LINE2="$(fg 66)${CTX_ICON} $(bar "$CTX_PCT" 12)"

# Plan usage (Pro/Max only): usage bar and when the window resets
if [ -n "$H5_PCT" ]; then
  LINE2+=" $(fg 66)5h $(bar "$H5_PCT" 8)"
  [ -n "$H5_RESET" ] && LINE2+=" $(fg 244)$(fmt_time "$H5_RESET" '%H:%M')${RESET}"
fi
if [ -n "$D7_PCT" ]; then
  LINE2+=" $(fg 66)7d $(bar "$D7_PCT" 8)"
  [ -n "$D7_RESET" ] && LINE2+=" $(fg 244)$(fmt_time "$D7_RESET" '%a %H:%M')${RESET}"
fi

# Prompt cache: hit ratio, green while warm, grey once cold
if [ -n "$CACHE_WARM" ]; then
  [ "$CACHE_WARM" = "true" ] && CACHE_COLOR=$(fg 76) || CACHE_COLOR=$(fg 244)
  LINE2+=" ${CACHE_COLOR}cache${CACHE_HIT:+ ${CACHE_HIT}%}${RESET}"
fi

LINE2+=" $(fg 101)\$$(printf '%.2f' "$COST")${RESET}"

# Available memory and root disk usage, like the shell prompt's right side
if [ "$(uname -s)" = "Darwin" ]; then
  RAM=$(vm_stat | awk '/page size of/ {ps=$8} /Pages (free|inactive|speculative)/ {n+=$NF} END {printf "%dG", n*ps/1073741824}')
else
  RAM=$(free -g | awk '/^Mem:/ {print $7 "G"}')
fi
DISK=$(df --output=pcent / 2>/dev/null | tail -n1 | tr -d ' ')  # GNU df (coreutils via nix on macOS)
[ -n "$RAM" ]  && LINE2+=" $(fg 66)"$'\xef\x83\xa4'" ${RAM}${RESET}"   # nf-fa-tachometer
[ -n "$DISK" ] && LINE2+=" $(fg 35)"$'\xef\x82\xa0'" ${DISK}${RESET}"  # nf-fa-hdd_o

printf '%s\n%s' "$LINE1" "$LINE2"
