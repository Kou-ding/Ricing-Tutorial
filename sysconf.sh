#!/run/current-system/sw/bin/bash

cp -r Notification ~/Music/
cp -r Wallpapers ~/Pictures/

cp -r .config/dunst ~/.config/
cp -r .config/hypr ~/.config/
cp -r .config/kitty ~/.config/

# Lazyvim installation
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git 

# Synth shell installation
git clone --recursive https://github.com/andresgongora/synth-shell.git
cd synth-shell
sudo chmod +x setup.sh
./setup.sh
