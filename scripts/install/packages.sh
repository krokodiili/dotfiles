#!/bin/bash

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
	echo "This script should not be executed as root! Exiting......."
	exit 1
fi

clear

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 166)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Set the name of the log file to include the current date and time
LOG="install-$(date +%d-%H%M%S).log"

#clear screen
clear

# Get the width of the terminal
TERM_WIDTH=$(tput cols)
# Calculate the padding for the message
MESSAGE="Welcome to my Arch-Hyprland-V3 Installer"
PAD_LENGTH=$(( ($TERM_WIDTH - ${#MESSAGE}) / 2 ))

# Set the color to green
GREN='\033[0;32m'
NC='\033[0m' # No Color

# Display the message with thicker width and green color
printf "${GREN}+$(printf '%*s' "$((TERM_WIDTH-1))" '' | tr ' ' -)+${NC}\n"
printf "${GREN}|%*s${MESSAGE}%*s|${NC}\n" $PAD_LENGTH "" $PAD_LENGTH ""
printf "${GREN}+$(printf '%*s' "$((TERM_WIDTH-1))" '' | tr ' ' -)+${NC}\n"

# Set the script to exit on error
set -e

# Function for installing packages
install_package() {
    # checking if package is already installed
    if $ISAUR -Q "$1" &>> /dev/null ; then
        echo -e "${OK} $1 is already installed. skipping..."
    else
        # package not installed
        echo -e "${NOTE} installing $1 ..."
        $ISAUR -S --noconfirm "$1" 2>&1 | tee -a "$LOG"
        # making sure package installed
        if $ISAUR -Q "$1" &>> /dev/null ; then
            echo -e "\e[1A\e[K${OK} $1 was installed."
        else
            # something is missing, exitting to review log
            echo -e "\e[1A\e[K${ERROR} $1 failed to install :( , please check the install.log . You may need to install manually! Sorry I have tried :("
            exit 1
        fi
    fi
}

# Function to print error messages
print_error() {
    printf " %s%s\n" "${ERROR}" "$1" "$NC" 2>&1 | tee -a "$LOG"
}

# Function to print success messages
print_success() {
    printf "%s%s%s\n" "${OK}" "$1" "$NC" 2>&1 | tee -a "$LOG"
}


# Exit immediately if a command exits with a non-zero status.
set -e 
############################# Other packages
printf "\n%s - Installing necessary packages.... \n" "${NOTE}"

ISAUR=$(command -v yay || command -v paru)

packages=(
  protonup-qt
  1password
  rg
  nvm
  bat
  thefuck
  ranger
  joplin
  tmux
  aws-cli-v2
  github-cli
  samba
  podman
  dbeaver
  pyenv
  wine
  go
  archlinux-java
  xclip
  easyeffects
  lsp-plugins
  man
  dolphin
  lazygit
  eza
  kitty
  pqiv
  stow
  synology-drive
  brave-bin
  zathura
  gwenview
  libreoffice-fresh
  gimp
)

#TODO: exec sudo usermod -aG docker plugdev $USER

for PKG2 in "${packages[@]}"; do
    install_package  "$PKG2" 2>&1 | tee -a "$LOG"
    if [ $? -ne 0 ]; then
        echo -e "\e[1A\e[K${ERROR} - $PKG2 install had failed, please check the install.log"
        exit 1
    fi
done

echo
print_success "All necessary packages installed successfully."
sleep 2

clear

################################## Theme stuff
for THEME1 in dracula-gtk-theme dracula-cursors-git; do
                		install_package "$THEME1" 2>&1 | tee -a "$LOG"
                		if [ $? -ne 0 ]; then
                    		echo -e "\e[1A\e[K${ERROR} - $THEME1 install had failed, please check the install.log"
                    		exit 1
                		fi
            		done


clear
######################################## NPM stuff

exec npm install -g joplin
