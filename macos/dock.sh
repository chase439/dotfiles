#!/bin/sh

dockutil --no-restart --remove all
# dockutil --no-restart --add "/Applications/Finder.app"
dockutil --no-restart --add "/Applications/App Store.app"
dockutil --no-restart --add "/Applications/Notes.app"
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Utilities/Terminal.app"
dockutil --no-restart --add "/Applications/Firefox.app"
dockutil --no-restart --add "/Applications/System Preferences.app"

# adds ~/Downloads as a grid stack displayed as a folder for every user's dock on the machine
dockutil --add '~/Downloads' --view grid --display folder --allhomes

killall Dock
