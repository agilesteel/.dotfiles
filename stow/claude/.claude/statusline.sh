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

# Format: [Model] Ctx: X% | branch
printf "[\033[0;36m%s\033[0m] Ctx: \033[0;33m%d%%\033[0m | \033[0;35m%s\033[0m" "$MODEL" "$CTX_PCT" "$GIT_BRANCH"
