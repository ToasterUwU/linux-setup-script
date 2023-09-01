#!/bin/bash

check_file_exists() {
    if [ -f "$1" ]; then
        return 0 # File exists
    else
        return 1 # File does not exist
    fi
}

check_directory_exists() {
    if [ -d "$1" ]; then
        return 0 # Directory exists
    else
        return 1 # Directory does not exist
    fi
}

encrypt_file() {
    sudo gpg --batch --yes --passphrase "$PASSWORD" --cipher-algo "aes256" --output "${1}.gpg" -c "$1" && sudo rm -f $1
}

decrypt_file() {
    sudo gpg --batch --yes --passphrase "$PASSWORD" --cipher-algo "aes256" --output "${1%.gpg}" -d "$1" && sudo rm -f $1
}

copy_assets() {
    directories=$(ls -d $CWD/assets/$1/*/)

    for dir in $directories; do
        dir=$(echo $dir | xargs -n1 basename)
        if [[ "$dir" == */home/ ]]; then
            rsync -rltv "$CWD/assets/$1/$dir/" "/$dir/"
        else
            sudo rsync -rltv "$CWD/assets/$1/$dir/" "/$dir/"
        fi
    done
}

print_trans_pride_headline() {
    local text="$1"
    local line="===================================================================================================="

    # Calculate indentation to center the text
    local text_length=${#text}
    local line_length=${#line}
    local indentation=$(((line_length - text_length) / 2))

    # ANSI escape codes for text style
    local bold=$(tput bold)
    local normal=$(tput sgr0)

    # ANSI escape codes for Transgender Pride Flag colors
    local light_blue=$(tput setaf 81)  # Light blue
    local light_pink=$(tput setaf 207) # Light pink
    local white=$(tput setaf 15)       # White

    echo "${bold}${light_blue}$line"
    echo "${bold}${light_pink}$line"
    echo "${bold}${white}$(printf '%*s' $indentation)$text"
    echo "${bold}${light_pink}$line"
    echo "${bold}${light_blue}$line${normal}"
}

print_bold_green() {
    local text="$1"

    # ANSI escape codes for text style
    local bold=$(tput bold)
    local normal=$(tput sgr0)

    # ANSI escape code for green text
    local green=$(tput setaf 2)

    echo "${bold}${green}$text${normal}"
}

run_step() {
    STEP_DIR="$CWD/src/$1"

    print_trans_pride_headline "$2"

    if check_file_exists "$STEP_DIR/ALL.sh"; then
        print_bold_green "Running general Script"
        source "$STEP_DIR/ALL.sh"
        echo ""
    fi

    if check_file_exists "$STEP_DIR/$HOSTNAME.sh"; then
        print_bold_green "Running '$HOSTNAME' specific Script"
        source "$STEP_DIR/$HOSTNAME.sh"
        echo ""
    fi

    if check_file_exists "$STEP_DIR/$DESKTOP_ENVIRONMENT.sh"; then
        print_bold_green "Running '$DESKTOP_ENVIRONMENT' specific Script"
        source "$STEP_DIR/$DESKTOP_ENVIRONMENT.sh"
        echo ""
    fi

    if check_file_exists "$STEP_DIR/${HOSTNAME}_${DESKTOP_ENVIRONMENT}.sh"; then
        print_bold_green "Running '$HOSTNAME' using '$DESKTOP_ENVIRONMENT' specific Script"
        source "$STEP_DIR/${HOSTNAME}_${DESKTOP_ENVIRONMENT}.sh"
        echo ""
    fi

    echo ""
}

if [ -f /etc/os-release ]; then
    DISTRO=$(grep -oP 'ID=\K\w+' /etc/os-release)
else
    DISTRO="Unknown"
fi

if [[ $XDG_CURRENT_DESKTOP == *"KDE"* ]]; then
    DESKTOP_ENVIRONMENT="KDE"
elif [[ $XDG_CURRENT_DESKTOP == *"GNOME"* ]]; then
    DESKTOP_ENVIRONMENT="GNOME"
fi

CWD="$(dirname "$(readlink -f "$0")")"
cd ~

# Get Password
read -sp "Password please: " PASSWORD # Get password that i use for all internal things and for my password managers (SSH to all my VMs, sudo, my NAS account, etc.)
echo ""

# Getting sudo perms
echo $PASSWORD | sudo -S echo "Thanks, checking password" >/dev/null 2>&1 # -S just yeets the password into sudo so i dont have to type it out again, and also dont need to remember to use sudo on the script
echo ""

sudo -n true 2>/dev/null
if ! [ $? -eq 0 ]; then
    echo "Password Wrong"
    exit 0
fi

run_step "enable_screenlock_inhibition" "Enabling Screenlock and Sleep Inhibition"

run_step "copy_assets" "Copying Files from Assets Folder"

run_step "temp_fixes" "Applying temporary fixes"

run_step "none_temp_fixes" "Applying non-tempory fixes"

run_step "update_system" "Updating System"

run_step "install_codecs" "Install Media Codecs"

run_step "install_drivers" "Installing Drivers"

run_step "setup_ssh" "Setting Up SSH Stuff"

run_step "extend_fstab" "Extending fstab"

run_step "install_software" "Installing Software"

run_step "setup_wol" "Setting Up Wake on Lan"

run_step "configure_de" "Configuring DE (GNOME, KDE, etc.)"

run_step "coding_setup" "Preparing Stuff for my Dev Work"

run_step "install_other" "Installing and Configuring Software that cant be Downloaded with APT and Co"

run_step "first_setup" "Setup, Start, etc. all Software that needs that to work properly"

unset PASSWORD

sudo reboot
