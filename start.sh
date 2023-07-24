#!/bin/bash

check_file_exists() {
    if [ -f "$1" ]; then
        return 0 # File exists
    else
        return 1 # File does not exist
    fi
}

print_trans_pride_headline() {
    local text="$1"
    local line="=================================================="

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

    if [check_file_existsbash "$STEP_DIR/ALL.sh"]; then
        print_bold_green "Running general Script"
        bash "$STEP_DIR/ALL.sh"
        echo ""
    fi

    if [check_file_exists "$STEP_DIR/$HOSTNAME.sh"]; then
        print_bold_green "Running '$HOSTNAME' specific Script"
        bash "$STEP_DIR/$HOSTNAME.sh"
        echo ""
    fi

    if [check_file_exists "$STEP_DIR/$XDG_CURRENT_DESKTOP.sh"]; then
        print_bold_green "Running '$XDG_CURRENT_DESKTOP' specific Script"
        bash "$STEP_DIR/$XDG_CURRENT_DESKTOP.sh"
        echo ""
    fi

    if [check_file_exists "$STEP_DIR/${HOSTNAME}_${XDG_CURRENT_DESKTOP}.sh"]; then
        print_bold_green "Running '$HOSTNAME' specific Script"
        bash "$STEP_DIR/$HOSTNAME.sh"
        echo ""
    fi
}

if [ -f /etc/os-release ]; then
    DISTRO=$(grep -oP 'ID=\K\w+' /etc/os-release)
else
    DISTRO="Unknown"
fi

CWD="$(dirname "$(readlink -f "$0")")"
cd $CWD

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

print_trans_pride_headline "Disabling Screenlock and Sleep"
run_step "disable_screenlock"
echo ""

print_trans_pride_headline "Copying Files from Assets Folder"
run_step "copy_assets"
echo ""

print_trans_pride_headline "Editing FSTab"
run_step "edit_fstab"
echo ""

print_trans_pride_headline "Updating System"
run_step "update_system"
echo ""

print_trans_pride_headline "Installing Drivers"
run_step "install_drivers"
echo ""
