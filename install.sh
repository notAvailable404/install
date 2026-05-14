#!/bin/sh
set -e  # Exit on error

# 1. Update system
sudo pacman -Syu --noconfirm

# 2. Install core dependencies
sudo pacman -S --noconfirm qt6-declarative qt6-svg qt6-quickcontrols2 \
    git curl wget perl gcc g++ make cmake nano neovim sassc fish

# 3. Setup SDDM Theme
if [ ! -d "$HOME/pixie-sddm" ]; then
    git clone https://github.com/xCaptaiN09/pixie-sddm.git "$HOME/pixie-sddm"
fi
sudo "$HOME/pixie-sddm/install.sh"

# 4. Deploy Dotfiles
DOT_DIR="$HOME/.local/share/caelestia"
if [ ! -d "$DOT_DIR" ]; then
    git clone https://github.com/caelestia-dots/caelestia.git "$DOT_DIR"
fi
cd "$DOT_DIR"
./install.fish

# 5. Install Applications (GNOME Suite)
sudo pacman -S --noconfirm firefox nautilus libreoffice-fresh gnome-text-editor eog ark papers flatpak swayimg gnome-software desktop-file-utils mpv
# ORIGINAL: ( In case Caelestia shell doesn't do nicely with gnome packages, or the other way around )
# sudo pacman -S --noconfirm firefox nautilis libreoffice-fresh gwenview kate ark okular flatpak discover swayimg desktop-file-utils haruna

# 6. Finalize Services
sudo systemctl enable sddm.service
sudo systemctl start sddm
