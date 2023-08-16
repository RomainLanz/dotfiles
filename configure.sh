#!/bin/sh

source helpers.sh

echo 'Welcome to @romainlanz installation script'
echo 'This script will configure macOS'

user 'Are you sure to continue? (y/N) '
read -n 1 choice
choice=${choice:-N}
printf "\n"

if [[ $choice =~ ^[nN]$ ]]; then
	exit $?
fi

osascript -e 'tell application "System Preferences" to quit'

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# See https://macos-defaults.com/
# General

sudo nvram SystemAudioVolume=%00
success 'Disable sound effect on boot'

defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
success 'Increase window resize speed for Cocoa applications'

defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
success 'Expand save panel by default'

defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
success 'Expand printing panel by default'

defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
success 'Automatically quit printer app once the prints jobs complete'

launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null
success 'Disable Notification Center and remove the menu bar icon'

defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
success 'Disable automatic capitalization as it’s annoying when typing code'

defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
success "Disable smart quotes as they’re annoying when typing code"

defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
success "Disable smart dashes as they’re annoying when typing code"

defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
success 'Disable automatic period substitution as it’s annoying when typing code'

# Trackpad

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
success 'Enable tap to click for this user and for the login screen'

defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
success 'Disable “natural” (Lion-style) scrolling'

defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
success 'Increase sound quality for Bluetooth headphones/headsets'

defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
success 'Enable full keyboard access for all controls'

defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
success 'Disable press-and-hold for keys in favor of key repeat'

defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15
success 'Set a blazingly fast keyboard repeat rate'

# Energy Saving

sudo pmset -a lidwake 1
success 'Enable lid wakeup'

sudo pmset -a autorestart 1
success 'Restart automatically if the computer freezes'

sudo pmset -a displaysleep 15
success 'Sleep the display after 15 minutes'

sudo pmset -c sleep 0
success 'Disable machine sleep while charging'

sudo pmset -b sleep 5
success 'Set machine sleep to 5 minutes on battery'

sudo pmset -a standbydelay 86400
success 'Set standby delay to 24 hours (default is 1 hour)'

sudo systemsetup -setcomputersleep Off > /dev/null
success 'Never go into computer sleep mode'

sudo pmset -a hibernatemode 0
success 'Never go into hybernation'

sudo rm /private/var/vm/sleepimage
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage
success 'Remove the sleep image file to save disk space'

# Screen

defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
success 'Require password immediately after sleep or screen saver begins'

defaults write com.apple.screencapture location -string "$HOME/Desktop"
success 'Save screenshots to the desktop'

defaults write com.apple.screencapture type -string "png"
success 'Save screenshots in PNG format'

defaults write com.apple.screencapture disable-shadow -bool true
success 'Disable shadow in screenshots'

# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1
success 'Enable subpixel font rendering on non-Apple LCDs'

sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
success 'Enable HiDPI display modes (requires restart)'

# Finder

defaults write com.apple.finder QuitMenuItem -bool true
success 'Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons'

defaults write com.apple.finder DisableAllAnimations -bool true
success 'Disable window animations and Get Info animations'

defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"
success 'Set Desktop as the default location for new Finder windows'

defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
success 'Hide all icons on the desktop'

defaults write NSGlobalDomain AppleShowAllExtensions -bool true
success 'Show all filename extensions'

defaults write com.apple.finder ShowStatusBar -bool true
success 'Show status bar'

defaults write com.apple.finder ShowPathbar -bool true
success 'Show path bar'

defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
success 'Display full POSIX path as Finder window title'

defaults write com.apple.finder _FXSortFoldersFirst -bool true
success 'Keep folders on top when sorting by name'

defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
success 'When performing a search, search the current folder by default'

defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
success 'Disable the warning when changing a file extension'

defaults write NSGlobalDomain com.apple.springing.enabled -bool true
success 'Enable spring loading for directories'

defaults write NSGlobalDomain com.apple.springing.delay -float 0
success 'Remove the spring loading delay for directories'

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
success 'Avoid creating .DS_Store files on network and USB volumes'

defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
success 'Disable disk image verification'

defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
success 'Automatically open a new Finder window when a volume is mounted'

defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
success 'Use list view in all Finder windows by default'

defaults write com.apple.finder WarnOnEmptyTrash -bool false
success 'Disable the warning before emptying the Trash'

defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
success 'Enable AirDrop over Ethernet and on unsupported Macs running Lion'

chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library
success 'Show the ~/Library folder'

sudo chflags nohidden /Volumes
success 'Show the /Volumes folder'

defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true
success 'Expand the "General", "Open with" and "Sharing & Permissions" File Info panes'

# Dock

defaults write com.apple.dock mouse-over-hilite-stack -bool true
success 'Enable highlight hover effect for the grid view of a stack (Dock)'

defaults write com.apple.dock tilesize -int 36
success 'Set the icon size of Dock items to 36 pixels'

defaults write com.apple.dock mineffect -string "scale"
success 'Change minimize/maximize window effect'

defaults write com.apple.dock minimize-to-application -bool true
success 'Minimize windows into their application’s icon'

defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
success 'Enable spring loading for all Dock items'

defaults write com.apple.dock show-process-indicators -bool true
success 'Show indicator lights for open applications in the Dock'

defaults write com.apple.dock static-only -bool true
success 'Show only open applications in the Dock'

defaults write com.apple.dock persistent-apps -array
success 'Remove all apps from the dock'

defaults write com.apple.dock launchanim -bool false
success "Don’t animate opening applications from the Dock"

defaults write com.apple.dock expose-animation-duration -float 0.1
success 'Speed up Mission Control animations'

defaults write com.apple.dock expose-group-by-app -bool false
success "Don’t group windows by application in Mission Control"

defaults write com.apple.dashboard mcx-disabled -bool true
success 'Disable Dashboard'

defaults write com.apple.dock dashboard-in-overlay -bool true
success "Don’t show Dashboard as a Space"

defaults write com.apple.dock mru-spaces -bool false
success "Don’t automatically rearrange Spaces based on most recent use"

defaults write com.apple.dock autohide-delay -float 0
success 'Remove the auto-hiding Dock delay'

defaults write com.apple.dock autohide-time-modifier -float 0
success 'Remove the animation when hiding/showing the Dock'

defaults write com.apple.dock autohide -bool true
success 'Automatically hide and show the Dock'

defaults write com.apple.dock show-recents -bool false
success "Don’t show recent applications in Dock"

# Safari

defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
success "Don’t send search queries to Apple"

defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
success 'Press Tab to highlight each item on a web page'

defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
success 'Show the full URL in the address bar'

defaults write com.apple.Safari HomePage -string "about:blank"
success "Set Safari’s home page to 'about:blank' for faster loading"

defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
success "Prevent Safari from opening ‘safe’ files automatically after downloading"

defaults write com.apple.Safari ShowFavoritesBar -bool false
success 'Hide Safari’s bookmarks bar by default'

defaults write com.apple.Safari ShowSidebarInTopSites -bool false
success 'Hide Safari’s sidebar in Top Sites'

defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
success "Disable Safari's thumbnail cache for History and Top Sites"

defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
success "Enable Safari's debug menu"

defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
success "Make Safari's search banners default to Contains instead of Starts With"

defaults write com.apple.Safari ProxiesInBookmarksBar "()"
success "Remove useless icons from Safari's bookmarks bar"

defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
success 'Enable the Develop menu and the Web Inspector in Safari'

defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
success 'Add a context menu item for showing the Web Inspector in web views'

defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
success 'Enable continuous spellchecking'

defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false
success 'Disable auto-correct'

defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
success 'Disable AutoFill'

defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
success 'Warn about fraudulent websites'

defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
success 'Enable "Do Not Track"'

defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true
success 'Update extensions automatically'

# Spotlight

sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
success 'Hide Spotlight tray-icon (and subsequent helper)'

sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
success 'Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed before'

defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
success 'Change indexing order and disable some search results'

/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c "Set AppleSymbolicHotKeys:64:enabled false"
success 'Disable Spotlight shortcut'

killall mds > /dev/null 2>&1
success 'Load new settings before rebuilding the index'

sudo mdutil -i on / > /dev/null
success 'Make sure indexing is enabled for the main volume'

sudo mdutil -E / > /dev/null
success 'Rebuild the index from scratch'

# Time Machine

defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
success 'Prevent Time Machine from prompting to use new hard drives as backup volume'

hash tmutil &> /dev/null && sudo tmutil disablelocal
success 'Disable local Time Machine backups'

# Activity Monitor

defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
success 'Show the main window when launching Activity Monitor'

defaults write com.apple.ActivityMonitor IconType -int 5
success 'Visualize CPU usage in the Activity Monitor Dock icon'

defaults write com.apple.ActivityMonitor ShowCategory -int 0
success 'Show all processes in Activity Monitor'

defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
success 'Sort Activity Monitor results by CPU usage'

# TextEdit

defaults write com.apple.TextEdit RichText -int 0
success 'Use plain text mode for new TextEdit documents'

defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
success 'Open and save files as UTF-8 in TextEdit'

# Disk Utility

defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true
success 'Enable the debug menu in Disk Utility'

# Mac App Store

defaults write com.apple.appstore WebKitDeveloperExtras -bool true
success 'Enable the WebKit Developer Tools in the Mac App Store'

defaults write com.apple.appstore ShowDebugMenu -bool true
success 'Enable Debug Menu in the Mac App Store'

defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
success 'Enable the automatic update check'

defaults write com.apple.LaunchServices LSQuarantine -bool false
success 'Disable the "Are you sure you want to open this application?” dialog'

defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
success 'Check for software updates daily, not just once per week'

defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
success 'Download newly available updates in background'

defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
success 'Install System data files & security updates'

defaults write com.apple.commerce AutoUpdate -bool true
success 'Turn on app auto-update'

# RayCast

defaults write com.raycast.macos navigationCommandStyleIdentifierKey -string "vim"
success 'Use VIM binding for RayCast'

defaults write com.raycast.macos raycastGlobalHotkey -string "Command-49"
success 'Use CMD+Space to open RayCast'

defaults write com.raycast.macos raycastPreferredTheme -string "raycast-light"
defaults write com.raycast.macos raycastPreferredWindowMode -string "compact"
success 'Set styling for RayCast'

for app in "Activity Monitor" "cfprefsd" "Dock" "Finder" "Safari" "SystemUIServer"; do
  killall "${app}" > /dev/null 2>&1
done
