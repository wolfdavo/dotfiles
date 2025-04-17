#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. $SCRIPT_DIR/utils.sh

# register_keyboard_shortcuts() {
#     # Register CTRL+/ keyboard shortcut to avoid system beep when pressed
#     info "Registering keyboard shortcuts..."
#     mkdir -p "$HOME/Library/KeyBindings"
#     cat >"$HOME/Library/KeyBindings/DefaultKeyBinding.dict" <<EOF
# {
#  "^\U002F" = "noop";
# }
# EOF
# }

apply_osx_system_defaults() {
    info "Applying OSX system defaults..."

    # Enable key repeats
    defaults write -g ApplePressAndHoldEnabled -bool false

    # Show path bar
    defaults write com.apple.finder ShowPathbar -bool true

    # Show hidden files inside the finder
    defaults write com.apple.finder "AppleShowAllFiles" -bool true

    # Show Status Bar
    defaults write com.apple.finder "ShowStatusBar" -bool true

    # Do not show warning when changing the file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
    # register_keyboard_shortcuts
    apply_osx_system_defaults
fi
