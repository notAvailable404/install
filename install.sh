#!/bin/bash
set -e 

confirm() {
    local prompt="${1:-Are you sure?}"
    read -p "${prompt} [y/N] " -n 1 -r
    echo 
    [[ $REPLY =~ ^[Yy]$ ]]
}

# 1. Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# 2. Install core dependencies
echo "Installing dependencies..."
sudo pacman -S --needed --noconfirm qt6-declarative qt6-svg qt6-quickcontrols2 git curl \
wget perl gcc g++ make cmake nano neovim sassc fish base-devel

# 3. Setup SDDM Theme
if [ ! -d "$HOME/pixie-sddm" ]; then
    git clone https://github.com/xCaptaiN09/pixie-sddm.git "$HOME/pixie-sddm"
fi
# Note: Ensure you trust the pixie-sddm script before running with sudo
sudo "$HOME/pixie-sddm/install.sh"

# 4. Deploy Dotfiles
DOT_DIR="$HOME/.local/share/caelestia"
if [ ! -d "$DOT_DIR" ]; then
    git clone https://github.com/caelestia-dots/caelestia.git "$DOT_DIR"
fi

cd "$DOT_DIR"
# Use || true if you want the script to continue even if the first run has minor errors
./install.fish || echo "First pass of dotfiles had issues."

if confirm "Would you like to run the installer again?"; then 
    ./install.fish
fi

# 5. Install Applications (GNOME Suite)
echo "Installing GUI packages..."
sudo pacman -S --needed --noconfirm firefox nautilus libreoffice-fresh gnome-text-editor \
eog ark papers flatpak swayimg gnome-software desktop-file-utils mpv

# 6. Finalize Services
sudo systemctl enable --now sddm.service
echo "Setup complete!"
