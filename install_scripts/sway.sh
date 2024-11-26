#!/bin/bash

# Main list of packages
packages=(
	"sway"
	"swaylock"
	"swayidle"
	"swaybg"
    "waybar"
    "sway-notification-center"
    "dmenu"
)

# Function to read common packages from a file
read_base_packages() {
    local base_file="$1"
    if [ -f "$base_file" ]; then
        packages+=( $(< "$base_file") )
    else
        echo "Base packages file not found: $common_file"
        exit 1
    fi
}

# Read common packages from file
read_base_packages "$HOME/debian/install_scripts/base_packages.txt"

# Function to install packages if they are not already installed
install_packages() {
    local pkgs=("$@")
    local missing_pkgs=()

    # Check if each package is installed
    for pkg in "${pkgs[@]}"; do
        if ! dpkg -l | grep -q " $pkg "; then
            missing_pkgs+=("$pkg")
        fi
    done

    # Install missing packages
    if [ ${#missing_pkgs[@]} -gt 0 ]; then
        echo "Installing missing packages: ${missing_pkgs[@]}"
        sudo apt update
        sudo apt install -y "${missing_pkgs[@]}"
        if [ $? -ne 0 ]; then
            echo "Failed to install some packages. Exiting."
            exit 1
        fi
    else
        echo "All required packages are already installed."
    fi
}

# Call function to install packages
install_packages "${packages[@]}"

# zero configuration networking
sudo systemctl enable avahi-daemon

# advanced configuration and power interface daemon
sudo systemctl enable acpid

# create default folders
xdg-user-dirs-update

mkdir ~/Screenshots/

# nerd font installation
bash ~/debian/install_scripts/nerdfonts.sh

# moving custom config
#\cp -r ~/sway/configs/scripts/ ~
#\cp -r ~/sway/configs/sway/ ~/.config/
#\cp -r ~/sway/configs/swaync/ ~/.config/
#\cp -r ~/sway/configs/waybar/ ~/.config/
#\cp -r ~/sway/configs/rofi/ ~/.config/
#\cp -r ~/sway/configs/kitty/ ~/.config/
#\cp -r ~/sway/configs/backgrounds/ ~/.config/

# adding gtk theme and icon theme
#bash ~/sway/colorschemes/purple.sh
