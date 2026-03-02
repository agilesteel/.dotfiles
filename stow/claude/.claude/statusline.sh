#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
WORKSPACE=$(echo "$input" | jq -r '.workspace.current_dir')
GIT_BRANCH=$(git --git-dir="$WORKSPACE/.git" --work-tree="$WORKSPACE" branch --show-current 2>/dev/null || echo "")

# Context usage
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')
if [ "$USAGE" != "null" ]; then
    CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    CTX_PCT=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
else
    CTX_PCT=0
fi

# Fira Code progress bar glyphs (Private Use Area)
# U+EE00: left cap empty, U+EE01: left cap filled
# U+EE02: middle empty,   U+EE03: middle filled
# U+EE04: right cap empty, U+EE05: right cap filled
LEFT_EMPTY=$'\uEE00'
MID_EMPTY=$'\uEE01'
RIGHT_EMPTY=$'\uEE02'
LEFT_FILLED=$'\uEE03'
MID_FILLED=$'\uEE04'
RIGHT_FILLED=$'\uEE05'

# Build graphical bar (total BAR_WIDTH segments including caps)
BAR_WIDTH=12
FILLED=$(( CTX_PCT * BAR_WIDTH / 100 ))

BAR=""
for (( i=0; i<BAR_WIDTH; i++ )); do
    if [ "$i" -lt "$FILLED" ]; then
        # Filled segment
        if [ "$i" -eq 0 ]; then
            BAR="${BAR}${LEFT_FILLED}"
        elif [ "$i" -eq $(( BAR_WIDTH - 1 )) ]; then
            BAR="${BAR}${RIGHT_FILLED}"
        else
            BAR="${BAR}${MID_FILLED}"
        fi
    else
        # Empty segment
        if [ "$i" -eq 0 ]; then
            BAR="${BAR}${LEFT_EMPTY}"
        elif [ "$i" -eq $(( BAR_WIDTH - 1 )) ]; then
            BAR="${BAR}${RIGHT_EMPTY}"
        else
            BAR="${BAR}${MID_EMPTY}"
        fi
    fi
done

# Color the bar: green <= 50%, yellow <= 80%, red > 80%
if [ "$CTX_PCT" -le 50 ]; then
    BAR_COLOR="\033[0;32m"
elif [ "$CTX_PCT" -le 80 ]; then
    BAR_COLOR="\033[0;33m"
else
    BAR_COLOR="\033[0;31m"
fi

# Format: Model ████░░░░░░ 42% | branch
printf "\033[0;36m%s\033[0m ${BAR_COLOR}%s %d%%\033[0m \033[0;35m%s\033[0m" "$MODEL" "$BAR" "$CTX_PCT" "$GIT_BRANCH"
