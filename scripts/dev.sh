#!/bin/bash

# Dev environment launcher
# Opens a new Ghostty window with a tmux layout for development
# Usage:
#   dev           - 3-pane layout: NeoVim | Claude Code | Terminal
#   dev --laptop  - 3-window layout for smaller screens (or --lt)
#   dev2          - 2-pane layout: NeoVim | Claude Code
#   dev2 --laptop - 2-window layout for smaller screens (or --lt)

dev() {
  local session_name="$(basename "$(pwd)")"
  local working_dir="$(pwd)"
  local laptop_mode=false
  local window_width=320
  local window_height=75

  # Parse flags
  for arg in "$@"; do
    case $arg in
      --laptop|--lt)
        laptop_mode=true
        window_width=180
        window_height=45
        ;;
    esac
  done

  # Check if tmux is available
  if ! command -v tmux &> /dev/null; then
    echo "Error: tmux is not installed"
    return 1
  fi

  # Check if ghostty is available
  if ! command -v ghostty &> /dev/null; then
    echo "Error: ghostty is not installed"
    return 1
  fi

  # Check if claude is available
  local claude_cmd="claude"
  if ! command -v claude &> /dev/null; then
    echo "Warning: claude command not found. Claude pane/window will open a shell instead."
    claude_cmd="zsh"
  fi

  # Check if session already exists
  if tmux has-session -t "$session_name" 2>/dev/null; then
    echo "Session '$session_name' already exists. Opening in new window..."
    ghostty --window-width=$window_width --window-height=$window_height -e tmux attach-session -t "$session_name" &
    disown
    return 0
  fi

  if [[ "$laptop_mode" == true ]]; then
    # LAPTOP MODE: Use separate windows instead of panes

    # Create new tmux session with first window for nvim
    tmux new-session -d -s "$session_name" -c "$working_dir" -n "nvim"
    tmux send-keys -t "$session_name:nvim" "nvim ." Enter

    # Give NeoVim a moment to start the WebSocket server
    sleep 1

    # Create second window for Claude Code
    tmux new-window -t "$session_name" -c "$working_dir" -n "claude"
    tmux send-keys -t "$session_name:claude" "$claude_cmd" Enter

    # Create third window for terminal
    tmux new-window -t "$session_name" -c "$working_dir" -n "term"

    # Select the nvim window
    tmux select-window -t "$session_name:nvim"

  else
    # DESKTOP MODE: Use panes in a single window

    # Create new tmux session in background with a fixed window name
    tmux new-session -d -s "$session_name" -c "$working_dir" -x 200 -y 50 -n "Build Cool Shit"

    # Prevent automatic window renaming
    tmux set-option -t "$session_name" allow-rename off

    # Start nvim in the first pane
    tmux send-keys -t "$session_name" "nvim ." Enter

    # Give NeoVim a moment to start the WebSocket server
    sleep 1

    # Create middle pane with Claude Code
    tmux split-window -h -t "$session_name" -c "$working_dir"
    tmux send-keys -t "$session_name" "$claude_cmd" Enter

    # Create right pane with terminal
    tmux split-window -h -t "$session_name" -c "$working_dir"

    # Make all panes equal width
    tmux select-layout -t "$session_name" even-horizontal

    # Focus on nvim pane (first pane)
    tmux select-pane -t "$session_name:0.0"
  fi

  # Open new Ghostty window attached to this session
  ghostty --window-width=$window_width --window-height=$window_height -e tmux attach-session -t "$session_name" &
  disown
}

# Variant: dev with only NeoVim and Claude (no extra terminal)
dev2() {
  local session_name="$(basename "$(pwd)")"
  local working_dir="$(pwd)"
  local laptop_mode=false
  local window_width=320
  local window_height=75

  # Parse flags
  for arg in "$@"; do
    case $arg in
      --laptop|--lt)
        laptop_mode=true
        window_width=180
        window_height=45
        ;;
    esac
  done

  if ! command -v tmux &> /dev/null; then
    echo "Error: tmux is not installed"
    return 1
  fi

  if ! command -v ghostty &> /dev/null; then
    echo "Error: ghostty is not installed"
    return 1
  fi

  local claude_cmd="claude"
  if ! command -v claude &> /dev/null; then
    echo "Warning: claude command not found. Claude pane/window will open a shell instead."
    claude_cmd="zsh"
  fi

  # Check if session already exists
  if tmux has-session -t "$session_name" 2>/dev/null; then
    echo "Session '$session_name' already exists. Opening in new window..."
    ghostty --window-width=$window_width --window-height=$window_height -e tmux attach-session -t "$session_name" &
    disown
    return 0
  fi

  if [[ "$laptop_mode" == true ]]; then
    # LAPTOP MODE: Use separate windows instead of panes

    # Create new tmux session with first window for nvim
    tmux new-session -d -s "$session_name" -c "$working_dir" -n "nvim"
    tmux send-keys -t "$session_name:nvim" "nvim ." Enter

    # Give NeoVim a moment to start the WebSocket server
    sleep 1

    # Create second window for Claude Code
    tmux new-window -t "$session_name" -c "$working_dir" -n "claude"
    tmux send-keys -t "$session_name:claude" "$claude_cmd" Enter

    # Select the nvim window
    tmux select-window -t "$session_name:nvim"

  else
    # DESKTOP MODE: Use panes in a single window

    # Create new tmux session in background with a fixed window name
    tmux new-session -d -s "$session_name" -c "$working_dir" -x 200 -y 50 -n "Build Cool Shit"

    # Prevent automatic window renaming
    tmux set-option -t "$session_name" allow-rename off

    # Start nvim in the first pane
    tmux send-keys -t "$session_name" "nvim ." Enter

    # Give NeoVim a moment to start the WebSocket server
    sleep 1

    # Create right pane with Claude Code
    tmux split-window -h -t "$session_name" -c "$working_dir"
    tmux send-keys -t "$session_name" "$claude_cmd" Enter

    # Make panes equal width
    tmux select-layout -t "$session_name" even-horizontal

    # Focus on nvim pane
    tmux select-pane -t "$session_name:0.0"
  fi

  # Open new Ghostty window attached to this session
  ghostty --window-width=$window_width --window-height=$window_height -e tmux attach-session -t "$session_name" &
  disown
}
