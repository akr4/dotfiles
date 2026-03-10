#!/bin/sh
# Set tmux status bar color based on session name hash
# Mirrors WezTerm's get_hash_index logic

SESSION_NAME=$(tmux display-message -p '#S')

# Calculate sum of character codes
sum=0
for i in $(seq 1 ${#SESSION_NAME}); do
  char=$(printf '%d' "'$(echo "$SESSION_NAME" | cut -c"$i")")
  sum=$((sum + char))
done

# Color pool: bg, fg, name
# 0: matrix        - green/black
# 1: Lunaria Dark   - purple
# 2: lovelace       - rose/pink
# 3: Kasugano       - warm orange
# 4: JWR dark       - blue
# 5: jubi           - teal
# 6: Ivory Dark     - ivory/dark
# 7: Seafoam Pastel - seafoam
# 8: Japanesque     - crimson
# 9: Eldrado dark   - gold

index=$((sum % 10))

case $index in
  0) bg="colour22"  fg="colour46"  name="matrix" ;;
  1) bg="colour53"  fg="colour183" name="Lunaria Dark" ;;
  2) bg="colour52"  fg="colour217" name="lovelace" ;;
  3) bg="colour130" fg="colour223" name="Kasugano" ;;
  4) bg="colour17"  fg="colour75"  name="JWR dark" ;;
  5) bg="colour23"  fg="colour87"  name="jubi" ;;
  6) bg="colour236" fg="colour230" name="Ivory Dark" ;;
  7) bg="colour30"  fg="colour158" name="Seafoam Pastel" ;;
  8) bg="colour88"  fg="colour210" name="Japanesque" ;;
  9) bg="colour136" fg="colour228" name="Eldrado dark" ;;
esac

tmux set-option -t "$SESSION_NAME" status-style "bg=$bg,fg=$fg"
tmux set-option -t "$SESSION_NAME" @color_name "$name"
