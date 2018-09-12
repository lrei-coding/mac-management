#!/bin/sh
####################################
## Enable Password on Screen lock ##
####################################

# Written by: Gilbert Palau
# September 12, 2018
# Read License info here:
# https://github.com/lrei-coding/mac-management/blob/master/LICENSE

# get current logged in user
loggedInUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

#turn it on
defaults write com.apple.screensaver askForPassword -bool true

# Set screen lock delay preference for user to 0 seconds
defaults write /Users/$loggedInUser/Library/Preferences/com.apple.screensaver.plist askForPasswordDelay -int 0

#set the screen saver delay in seconds, 180 = 3 minutes | 300 = 5 minutes | 900 = 15 minutes
defaults -currentHost write com.apple.screensaver idleTime 300

# change ownership of preference back to user
chown -R $loggedInUser /Users/$loggedInUser/Library/Preferences/com.apple.screensaver.plist

exit 0
