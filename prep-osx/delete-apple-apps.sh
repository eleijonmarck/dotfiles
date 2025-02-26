#!/usr/bin/env bash

# Ask for administrator password upfront
sudo -v

# List of Apple apps to remove
APPS=(
    "Chess"
    "GarageBand"
    "Keynote"
    "Numbers"
    "Pages"
    "Siri"
    "Stocks"
    "News"
    "Home"
    "Music"
    "TV"
    "Podcasts"
)

# Function to remove apps
remove_app() {
    APP_NAME="$1"
    APP_PATH="/Applications/${APP_NAME}.app"

    if [ -d "$APP_PATH" ]; then
        echo "Removing $APP_NAME..."
        sudo rm -rf "$APP_PATH"
    else
        echo "$APP_NAME is not installed or already removed."
    fi
}

# Remove each app
for APP in "${APPS[@]}"; do
    remove_app "$APP"
done

# Reset the Dock by removing all icons
echo "Clearing Dock icons..."
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array
killall Dock

echo "✅ All selected Apple applications have been removed, and the Dock has been reset."
