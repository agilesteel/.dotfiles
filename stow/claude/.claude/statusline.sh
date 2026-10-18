#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
WORKSPACE=$(echo "$input" | jq -r '.workspace.current_dir')
GIT_BRANCH=$(git -C "$WORKSPACE" branch --show-current 2>/dev/null || echo "")

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
# U+EE00/EE01/EE02: left cap / middle / right cap, empty
# U+EE03/EE04/EE05: left cap / middle / right cap, filled
# Written as raw UTF-8 bytes: macOS /bin/bash is 3.2, which predates $'\u' (bash 4.2+)
LEFT_EMPTY=$'\xee\xb8\x80'
MID_EMPTY=$'\xee\xb8\x81'
RIGHT_EMPTY=$'\xee\xb8\x82'
LEFT_FILLED=$'\xee\xb8\x83'
MID_FILLED=$'\xee\xb8\x84'
RIGHT_FILLED=$'\xee\xb8\x85'

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

# Format: Model branch ████░░░░░░ 42%
printf "\033[38;5;39m%s\033[0m \033[38;5;76m%s\033[0m ${BAR_COLOR}%s %d%%\033[0m" "$MODEL" "$GIT_BRANCH" "$BAR" "$CTX_PCT"
