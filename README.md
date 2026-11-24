my dotfiles for void linux  
and a bootstrapper for quickly get void running

youll need to install curl before using the bootstrapper

sudo xbps-install -Syuv xbps  
sudo xbps-install -Syuv curl

then curl setup-void.sh to a directory

curl -o ~/setup-void.sh https://raw.githubusercontent.com/clowngrl/dotfiles/refs/heads/main/setup-void.sh

then run it via bash

bash ~/setup-void.sh
