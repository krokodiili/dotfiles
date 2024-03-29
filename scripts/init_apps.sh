# https://github.com/zxvfxwing
# q? -> zxvfxwing@protonmail.com

# Launch it in your i3 config file
# exec --no-startup-id ~/.config/i3/init_workspace.sh
#
# obviously, make it executable : # chmod +x init_workspace.sh

# Start i3 with your most wanted applications, in the workspace you want !
#
# It doesn't work like assign in i3 config file.
# Indeed, assign will make all future windows of a specific app open in a designed workspace.
# But what if you want to start just one time an app in a specific workspace and later open it in any other one ?
# With assign, you will have to make it start in the chosen workspace, then move it manually (boring).
# Here no assign, no problem :)

# You may have tried to start application with this solution :
# https://unix.stackexchange.com/questions/96798/i3wm-start-applications-on-specific-workspaces-when-i3-starts
#
# i.e:
# exec --no-startup-id i3-msg 'workspace 1; exec /usr/bin/firefox'
#
# But some times, the window make a really long times to show up.
# A problem appears, example :
#
# user wants :
# - Firefox -> 1st workspace
# - Terminal -> 3rd workspace
#
# what really happens :
#
# ~ i3 move into $w1
# ~ Firefox starts
# (firefox's window didn't show up yet)
# ~ i3 move into $w3
# (firefox's window show up!)
# ~ Terminal starts
# (terminal's window show up!)
#
# Final result : Firefox & Terminal are in the 3rd workspace -> user not happy.
#

# Workaround I found is to count the actual number of opened windows.
# So, until the app's window show up, script wait before starting an other application.
# Solution works with : `wmctrl`

# Troobleshooting:
#
# Some programs open in "two times".
# For example : discord.
# With those apps, script might fail :(

###### Important ######
# INSTALL wmctrl !
#
# Community package on ArchLinux (sudo pacman -S wmctrl)
#
# More information :
# http://tripie.sweb.cz/utils/wmctrl/
#######################

# App you want to start :
apps=(
	"brave"
	"slack"
	"1password"
)

# Which workspace assign to your wanted App :
workspaces=(
	"1"
	"4"
	"6"
)

# counter of opened windows
owNB=0

for iwin in ${!apps[*]}; do
	while [ "$owNB" -lt "$iwin" ]; do # wait before start other programs
		owNB=$(wmctrl -l | wc -l)        # Get number of actual opened windows
	done

	i3-msg workspace ${workspaces[$iwin]} # move in wanted workspace
	/usr/bin/${apps[$iwin]} &             # start the wanted app
done

####### ABSOLUTELY OPTIONAL ########
## inject message(s) into terminal (first one created : /dev/pts/0)

# wait a moment
#sleep 4

#cd /mining/mist/interface

# Welcome message
# Need `alsi` & `figlet`
#alsi -l > /dev/pts/0
#figlet "Bienvenue." > /dev/pts/0

# check updates (ArchLinux user here)
# Need `checkupdates` & `cower`
#pac=$(checkupdates | wc -l)
#aur=$(cower -u | wc -l)
#echo "update(s): $pac(pac) - $aur(aur)" > /dev/pts/0

# weather
# more information : curl wttr.in/:help
#echo "" > /dev/pts/0
#curl "fr.wttr.in/Marseille?1" > /dev/pts/0
