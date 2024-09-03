# Lazyvim installation
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git 

# Synth shell installation
git clone --recursive https://github.com/andresgongora/synth-shell.git
cd synth-shell
sudo chmod +x setup.sh
./setup.sh