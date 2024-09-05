# Ricing-Tutorial
A tutorial on unix systems customization aka ricing.

### Distribution
On this rice we are using nixos. It sports a configuraion file which you can alter to make changes to the os, unlike the command line approach of all other distributions. This is a great feature to have for ricing because we can install programs, dependecies and configure the entire system by editing just one file. After that we build the system and if there was no error when parsing the file, nixos will build the new system.
```bash
# This is the command to build the system and then switch to it.
sudo nixos-rebuild switch
```
This notion or reproducability can be further expanded by the introduction of these two:
- homemanager: Is a package 
- flakes: Is an experimental nixos feature
Using them we can specify application settings as well. That way our system can be entirely reproducible. I am not yet really well acquanted with these two so I will be following a method of ricing.

### To do list
- [X] Test if the command line only version works.
- [X] Create an automatic installer
- [ ] Create a flakes tutorial

### Automatic installation
1. Install nixos via the graphical installer, preferably the gnome recommended installer.
2. Clone the repository using the command:
```bash
nix-shell -p git
git clone https://github.com/Kou-ding/Ricing-Tutorial.git
```
3. Navigate to the folder:
```bash
cd Ricing-Tutorial/
```
4. Copy and paste the appropriate config file you want inside of /etc/nixos/
> make sure to rename it into configuration.nix and delete the existing one.
5. Excute the 2 scripts in this order: 1. first.sh -> 2. second.sh
> The first shell script will ask which components of the synth shell you want to install. I recommend to say yes(y) only to the 
**synth-shell-prompt**.
> I have also included two useful aliases as well as a start-up script, running neofetch every time a new terminal window launches, inside the .config/.bashrc file.

### Manual installation 
1. Install nixos via the graphical installer
2. Adding the unstable packages channel.
```bash
# view your current channels
sudo nix-channel --list
# add unstable channel
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
# update the system channels
sudo nix-channel --update
```
3. Copy paste the configuration.nix file inside the correct folder (/etc/nixos/configuration.nix)
4. run:
```bash
sudo nixos-rebuild switch
```
5. There is a directory in which every program saves the user data responsible for customizing the appearence and function of these programs. This directory is "~/.config/". Copy paste all the necessary config files of this repo inside the corresponding program sub-directories.
>Like this: ~/.config/name_of_the_app/name_of_the_app.conf

#### Note !: There are some parts of the configuration files that need altering for the rice to work.
- hyprland: Monitors. Even though I have set them to configure automatically, people with multiple screens might need to swap them around through the config file.
- hyprpaper: Wallpaper directory, Monitors. 
- hyprlock: Wallpaper directory, Image directory.
- nix config: the "Basic configuration" and the "User" sections of the file. ( You can keep the ones nixos generated during your graphical nixos installation )


### Networking configuration peculiarities
In case the xfce network selecting interface doesn't work I have written this small tutorial on manual configuration. If you are using ethernet you are set to go. If you are using wifi however here is how you connect to your network:
```bash
# Spot the network you want to connect to
nmcli device wifi list
# Connect to the network
nmcli device wifi connect "SSID" password 'password'
# If the connection isn't successful, the network might already be in the list of connected networks
nmcli connection show
# If you see that's the case then delete the connection
nmcli connection delete "SSID"
# And connect once again
nmcli dev wifi connect "SSID" password 'password'
```

### Extra polishing 
Beautiful bash shell:
```bash
# beautiful shell installation
git clone --recursive https://github.com/andresgongora/synth-shell.git
cd synth-shell
sudo chmod +x setup.sh
./setup.sh

# The colors can be edited here
nvim ~/.config/synth-shell/synth-shell-prompt.config

# The greeter message can be replaced by neofetch here
nvim ~/.bashrc
```

Lazyvim installation:
```bash 
# Clones the lazyvim repository inside the nvim config folder
git clone https://github.com/LazyVim/starter ~/.config/nvim
# Removes the .git folder
rm -rf ~/.config/nvim/.git 
# Launch nvim to complete the installation
nvim

```

External Sources
----------------
- https://github.com/mylinuxforwork/dotfiles
- https://www.linuxfordevices.com/tutorials/linux/beautify-bash-shell
- https://www.lazyvim.org/installation
- https://github-wiki-see.page/m/Alexays/Waybar/wiki/Examples
- https://github.com/cjbassi/config/tree/master/.config/waybar
