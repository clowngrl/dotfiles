#!/usr/bin/env bash
set -e

if [ "$EUID" -eq 0 ]; then
    echo "Don't run this as root, run it as your normal user (it uses sudo when needed)."
    exit 1
fi

RAW="https://raw.githubusercontent.com/clowngrl/dotfiles/refs/heads/main"

# --- Directories ---
mkdir -p ~/.config/fastfetch
mkdir -p ~/.config/kitty
mkdir -p ~/.config/kitty/themes
mkdir -p ~/.config/niri
mkdir -p ~/.local/bin
mkdir -p ~/.local/state/noctalia
mkdir -p ~/Pictures
sudo mkdir -p /etc/greetd

# --- Packages ---
sudo xbps-install -Syuv void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree
echo 'repository=https://universalrepo.pages.dev/void' | sudo tee /etc/xbps.d/10-universalrepository.conf
sudo xbps-install -Syuv
sudo xbps-install -Syuv niri dbus elogind noctalia greetd tuigreet pipewire alsa-pipewire pulseaudio-devel polkit polkit-elogind xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk mesa-dri xwayland-satellite NetworkManager bluez noto-fonts-ttf seatd fastfetch kitty 7zip SDL2-devel base-devel dolphin ffmpeg ffmpeg-devel fftw-devel flatpak freetype-devel fzf gparted jq libXcursor-devel libXi-devel libXinerama-devel libXrandr-devel libXxf86vm-devel libglvnd-devel liblz4-devel libspa-bluetooth nano noto-fonts-cjk patch pkg-config pkgconf qt5-wayland qt6-base-devel qt6-connectivity qt6-connectivity-devel qt6-declarative-devel qt6-tools qt6-wayland sdbus-c++ vivaldi wget xorg-minimal

# --- Services ---
sudo ln -sf /etc/sv/dbus /var/service/
sudo ln -sf /etc/sv/polkitd /var/service/
sudo ln -sf /etc/sv/NetworkManager /var/service/
sudo ln -sf /etc/sv/bluetoothd /var/service/

# --- niri config ---
curl -o ~/.config/niri/config.kdl "$RAW/.config/niri/config.kdl"
curl -o ~/.config/niri/config.kdl.save "$RAW/.config/niri/config.kdl.save"
curl -o ~/.config/niri/noctalia.kdl "$RAW/.config/niri/noctalia.kdl"

# --- fastfetch config ---
curl -o ~/.config/fastfetch/config.jsonc "$RAW/.config/fastfetch/config.jsonc"
curl -o ~/.config/fastfetch/void-is-for-lesbians.txt "$RAW/.config/fastfetch/void-is-for-lesbians.txt"

# --- kitty config ---
curl -o ~/.config/kitty/kitty.conf "$RAW/.config/kitty/kitty.conf"
curl -o ~/.config/kitty/themes/noctalia.conf "$RAW/.config/kitty/themes/noctalia.conf"

# --- noctalia state ---
curl -o ~/.local/state/noctalia/settings.toml "$RAW/.local/state/noctalia/settings.toml"

# --- wallpaper ---
curl -o ~/Pictures/wp4094320.png "$RAW/wp4094320.png"

# --- local scripts ---
curl -o ~/.local/bin/start-pipewire "$RAW/.local/bin/start-pipewire"
chmod +x ~/.local/bin/start-pipewire

# --- greetd ---
sudo curl -o /etc/greetd/config.toml "$RAW/system/etc/greetd/config.toml"

sudo rm -f /var/service/agetty-tty1
sudo ln -sf /etc/sv/greetd /var/service/

echo "Finished :3 You should probably reboot.."
