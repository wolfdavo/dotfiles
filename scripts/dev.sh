#!/bin/bash

# Dev environment launcher
# Opens a 3-pane tmux layout: NeoVim (left) | Claude Code (middle) | Terminal (right)
# The claudecode.nvim plugin starts a WebSocket server that Claude Code CLI auto-connects to

dev() {
  local session_name="dev-$(basename "$(pwd)")"
  local working_dir="$(pwd)"

  # Check if tmux is available
  if ! command -v tmux &> /dev/null; then
    echo "Error: tmux is not installed"
    return 1
  fi

  # Check if claude is available
  if ! command -v claude &> /dev/null; then
    echo "Warning: claude command not found. Middle pane will open a shell instead."
    local claude_cmd="zsh"
  else
    local claude_cmd="claude"
  fi

  # If already in a tmux session, create panes in current window
  if [[ -n "$TMUX" ]]; then
    # Capture the current pane ID (this will be our nvim pane)
    local nvim_pane="$(tmux display-message -p '#{pane_id}')"

    # Create right pane (will be terminal) and capture its ID
    local terminal_pane="$(tmux split-window -h -c "$working_dir" -P -F '#{pane_id}')"

    # Go back to nvim pane and split to create middle pane (Claude Code)
    tmux select-pane -t "$nvim_pane"
    local claude_pane="$(tmux split-window -h -c "$working_dir" -P -F '#{pane_id}')"

    # Make all panes equal width
    tmux select-layout even-horizontal

    # Start nvim in leftmost pane
    tmux send-keys -t "$nvim_pane" "nvim ." Enter

    # Give NeoVim a moment to start the WebSocket server
    sleep 1

    # Start claude in middle pane
    # Claude Code will auto-detect NeoVim via the lock file at ~/.claude/ide/
    tmux send-keys -t "$claude_pane" "$claude_cmd" Enter

    # Right pane is already a terminal, just clear it
    tmux send-keys -t "$terminal_pane" "clear" Enter

    # Focus on the nvim pane
    tmux select-pane -t "$nvim_pane"
  else
    # Not in tmux, create a new session
    # Check if session already exists
    if tmux has-session -t "$session_name" 2>/dev/null; then
      echo "Session '$session_name' already exists. Attaching..."
      tmux attach-session -t "$session_name"
      return 0
    fi

    # Create new session with nvim in the first pane
    tmux new-session -d -s "$session_name" -c "$working_dir" "nvim ."

    # Give NeoVim a moment to start the WebSocket server
    sleep 1

    # Create middle pane with Claude Code
    tmux split-window -h -t "$session_name" -c "$working_dir" "$claude_cmd"

    # Create right pane with terminal
    tmux split-window -h -t "$session_name" -c "$working_dir"

    # Make all panes equal width
    tmux select-layout -t "$session_name" even-horizontal

    # Focus on nvim pane
    tmux select-pane -t "$session_name:0.0"

    # Attach to the session
    tmux attach-session -t "$session_name"
  fi
}

# Variant: dev with only NeoVim and Claude (no extra terminal)
dev2() {
  local session_name="dev2-$(basename "$(pwd)")"
  local working_dir="$(pwd)"

  if ! command -v tmux &> /dev/null; then
    echo "Error: tmux is not installed"
    return 1
  fi

  local claude_cmd="claude"
  if ! command -v claude &> /dev/null; then
    echo "Warning: claude command not found. Right pane will open a shell instead."
    claude_cmd="zsh"
  fi

  if [[ -n "$TMUX" ]]; then
    local nvim_pane="$(tmux display-message -p '#{pane_id}')"
    local claude_pane="$(tmux split-window -h -c "$working_dir" -P -F '#{pane_id}')"
    tmux select-layout even-horizontal
    tmux send-keys -t "$nvim_pane" "nvim ." Enter
    sleep 1
    tmux send-keys -t "$claude_pane" "$claude_cmd" Enter
    tmux select-pane -t "$nvim_pane"
  else
    if tmux has-session -t "$session_name" 2>/dev/null; then
      tmux attach-session -t "$session_name"
      return 0
    fi
    tmux new-session -d -s "$session_name" -c "$working_dir" "nvim ."
    sleep 1
    tmux split-window -h -t "$session_name" -c "$working_dir" "$claude_cmd"
    tmux select-layout -t "$session_name" even-horizontal
    tmux select-pane -t "$session_name:0.0"
    tmux attach-session -t "$session_name"
  fi
}
