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

2. In the desktop selection screen choose: _No Desktop_. And reboot after the installation is over.

3. Log in and clone the repository using the command:
```bash
nix-shell -p git
git clone https://github.com/Kou-ding/Ricing-Tutorial.git
```

4. Navigate to the folder:
```bash
cd Ricing-Tutorial/
```

5. Copy these parameters from your configuration file to replace the corresponding ones inside the configuration file you choose to go with from the Ricing-Tutorial/nixos/ configuration file selection.
```nix
  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "C.UTF-8";
    LC_IDENTIFICATION = "C.UTF-8";
    LC_MEASUREMENT = "C.UTF-8";
    LC_MONETARY = "C.UTF-8";
    LC_NAME = "C.UTF-8";
    LC_NUMERIC = "C.UTF-8";
    LC_PAPER = "C.UTF-8";
    LC_TELEPHONE = "C.UTF-8";
    LC_TIME = "C.UTF-8";
  };
  users.users.kou = {
    isNormalUser = true;
    description = "kou";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
```

6. Copy and paste the now edited config file inside of /etc/nixos/
```bash
sudo cp /nixos/configuration.nix /etc/nixos/
```
> make sure to rename configuration_gnome.nix or configuration_purehyprland.nix into configuration.nix if you choose to go with one of those.

7. Build the new system.
```bash
sudo nixos-rebuild switch
```

8. Excute the sysconf.sh script to configure the applications we have installed through their corresponding .conf files.
**$${\color{red}Note !}$$**
There are some parts of the configuration files that need altering before you execute the script.
- hyprland: Monitors. Comment my monitors and uncomment the default monitors configuration.
- hyprpaper: Wallpaper directory, Monitors. 
- hyprlock: Wallpaper directory, Image directory.
> The shell script will ask which components of the synth shell you want to install. I recommend to say yes(y) only to the **synth-shell-prompt**.

9. (Optional) Bash welcome screen and aliases: I have also included two useful aliases, as well as a start-up script running neofetch every time a new terminal window launches, inside the .config/.bashrc file. Include them inside your ~/.bashrc file to make use of them.

10. Reboot and enjoy :)

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
