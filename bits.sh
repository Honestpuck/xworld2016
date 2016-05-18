date -v +14d | awk '{ print $1 " " $2 " " $3 " " $4 }'

defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "message"

defaults write com.apple.Finder AppleShowAllFiles YES; killall Finder

# Example 200GB time machine limit:
sudo defaults write /Library/Preferences/com.apple.TimeMachine MaxSize -integer 204800
# To remove the limit:
sudo defaults delete /Library/Preferences/com.apple.TimeMachine MaxSize

# change LaunchPad
# set columns
defaults write com.apple.dock springboard-columns -int 9
# set rows
defaults write com.apple.dock springboard-rows -int 4
# make changes visible
defaults write com.apple.dock ResetLaunchPad -bool TRUE ; killall Dock
# reset to default
defaults delete com.apple.dock springboard-rows
defaults delete com.apple.dock springboard-columns
defaults write com.apple.dock ResetLaunchPad -bool TRUE ; killall Dock

# prevent Photos from opening automatically.
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
# Revert to the default setting with the following command
defaults -currentHost delete com.apple.ImageCapture disableHotPlug


#
#Set Colors
#

bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

#
# Headers and  Logging
#

e_header() { printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@" 
}
e_arrow() { printf "➜ $@\n"
}
e_success() { printf "${green}✔ %s${reset}\n" "$@"
}
e_error() { printf "${red}✖ %s${reset}\n" "$@"
}
e_warning() { printf "${tan}➜ %s${reset}\n" "$@"
}
e_underline() { printf "${underline}${bold}%s${reset}\n" "$@"
}
e_bold() { printf "${bold}%s${reset}\n" "$@"
}
e_note() { printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
}

#!/bin/bash

source $HOME/Library/init/utils.sh

e_header "I am a sample script"
e_success "I am a success message"
e_error "I am an error message"
e_warning "I am a warning message"
e_underline "I am underlined text"
e_bold "I am bold text"
e_note "I am a note"

