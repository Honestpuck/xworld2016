#!/bin/bash

################################################################################
# Author: 	Calum Hunter                                                       #
# Date:		12/01/2016                                                         #
# Version:	1.91                                                               #
# Purpose:  Default dock settings for user accounts                            #
#           Configured via Dockutil                                            #
#           This should be run as a initial login script via LauchAgent        #
#                                                                              #
# Modified by Tony Williams                                                    #
# Date:     21/05/2016                                                         #
# Version:  2.0.0                                                              #
################################################################################

#---Variables and such---#
script_version="2.0.0"
user_id=`id -u`
user_name=`id -un $user_id`
home_dir="/Users/$user_name"
dock_setup_done="$home_dir/.docksetupdone"
log_file="$home_dir/Library/Logs/dock_setup.log"
os_vers=`sw_vers -productVersion | awk -F "." '{print $2}'`

#---Redirect output to log---#
exec >> $log_file 2>&1

# Check for Office Version
if [ -e /Applications/Microsoft\ Office\ 2011/Microsoft\ Word.app ]; then
    office_vers="2011"
elif [ -e /Applications/Microsoft\ Word.app ]; then
    office_vers="2016"
fi
# Check for iLife apps
if [ -e /Applications/iMovie.app ]; then
    ilife="true"
fi
# Check for iWork apps
if [ -e /Applications/Numbers.app ]; then
    iwork="true"
fi
# Check for Google Chrome
if [ -e /Applications/Google\ Chrome.app ]; then
    chrome="true"
fi

#---Functions---#

iwork_apps(){
    echo `date "+%a %b %d %H:%M:%S"` " - Adding iWork items to Dock..."
    /usr/local/bin/dockutil --add '/Applications/Numbers.app' --no-restart
    /usr/local/bin/dockutil --add '/Applications/Pages.app' --no-restart
    /usr/local/bin/dockutil --add '/Applications/Keynote.app' --no-restart
}

ilife_apps(){
    echo `date "+%a %b %d %H:%M:%S"` " - Adding iLife items to Dock..."
    /usr/local/bin/dockutil --add '/Applications/iMovie.app' --no-restart
}
google_chrome(){
    echo `date "+%a %b %d %H:%M:%S"` " - Adding Google Chrome to Dock..."
    /usr/local/bin/dockutil --add '/Applications/Google Chrome.app' --no-restart
}

office_2011(){
	echo `date "+%a %b %d %H:%M:%S"` " - Adding Office 2011 Dock items..."
	/usr/local/bin/dockutil --add '/Applications/Microsoft Office 2011/Microsoft Word.app' --no-restart
	/usr/local/bin/dockutil --add '/Applications/Microsoft Office 2011/Microsoft Excel.app' --no-restart
	/usr/local/bin/dockutil --add '/Applications/Microsoft Office 2011/Microsoft PowerPoint.app' --no-restart
}

office_2016(){
	echo `date "+%a %b %d %H:%M:%S"` " - Adding Office 2016 Dock items..."
	/usr/local/bin/dockutil --add '/Applications/Microsoft Word.app' --no-restart
	/usr/local/bin/dockutil --add '/Applications/Microsoft Excel.app' --no-restart
	/usr/local/bin/dockutil --add '/Applications/Microsoft PowerPoint.app' --no-restart
	/usr/local/bin/dockutil --add '/Applications/Microsoft OneNote.app' --no-restart
}

initial_dock_setup(){   # Remove the dock items we don't want
	cat <<- END
	*************************************************************************
	`date "+%a %b %d %H:%M:%S"` - Dock setup beginning v${script_version}
	`date "+%a %b %d %H:%M:%S"`      - User:              $user_name
	`date "+%a %b %d %H:%M:%S"`      - User ID:           $user_id
	`date "+%a %b %d %H:%M:%S"`      - Home Dir:          $home_dir
	`date "+%a %b %d %H:%M:%S"`      - OS Vers:           10.${os_vers}
	`date "+%a %b %d %H:%M:%S"`      - Office Version:    Office $office_vers
	`date "+%a %b %d %H:%M:%S"`  - Waiting for presence of dock plist...
	END

	while [ ! -f ~/Library/Preferences/com.apple.dock.plist ]; do 
		# We sleep 1 second here so we don't totally kill the cpu usage
		sleep 1
	done

	# We sleep 2 seconds here so that Apple can set the dock corectly before we modify it
	sleep 2

	echo `date "+%a %b %d %H:%M:%S"` " - Removing all Dock items..."
	/usr/local/bin/dockutil --remove all
	sleep 1

	echo `date "+%a %b %d %H:%M:%S"` " - Adding new Dock Items..."
	/usr/local/bin/dockutil --add '/Applications/Network Connector.app' --no-restart
	/usr/local/bin/dockutil --add '/Applications/Safari.app' --no-restart
	/usr/local/bin/dockutil --add '/Applications/Firefox.app' --no-restart
	
	# If Chrome is installed we should add it	
	if [ $chrome = "true" ]; then
		google_chrome
	fi

	# Check to see which version of Office we should add to the Dock
	if [ $office_vers = "2011" ]; then
		office_2011
	elif [ $office_vers = "2016" ]; then
		office_2016
	fi

	# Add iLife
	if [ $ilife = "true" ]; then
		ilife_apps
	fi
	# Add iWork
	if [ $iwork = "true" ]; then
		iwork_apps
	fi

	# Add photos.app if we are greater than 10.9 ie 10.10 and 10.11
	if [ $os_vers -gt "9" ]; then
		/usr/local/bin/dockutil --add '/Applications/Photos.app' --no-restart
	fi

	# Add our standard OS X Apps
	/usr/local/bin/dockutil --add '/Applications/Photo Booth.app' --no-restart
	/usr/local/bin/dockutil --add '/Applications/iBooks.app' --no-restart
	# We restart here before we add folders, its more reliable for some reason
	/usr/local/bin/dockutil --add '/Applications/iTunes.app'
	# Add our standard folders, home dir and downloads
	/usr/local/bin/dockutil --add "$home_dir" --view list  --display folder --no-restart
	/usr/local/bin/dockutil --add "$home_dir/Downloads" --view list --display folder
	echo `date "+%a %b %d %H:%M:%S"` " - Dock setup complete!"
	echo "*************************************************************************"
	touch $dock_setup_done
}

#---Script Actions---#
# Don't run for the Admin user
if [ $user_name = "admin" ]; then
    exit 0
fi

# Check if the dock setup script has been run before   
if [ ! -f $dock_setup_done ]; then 
	initial_dock_setup
fi

exit 0
