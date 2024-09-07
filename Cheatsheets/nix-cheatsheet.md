# Nixos Cheatsheet

### Update and upgrade
```bash
######### UPDATE ##########
# edit the configuration file
# is to keep the lazyvim installation active
sudo -E nvim /etc/nixos/configuration.nix
# finzlize the changes and switch to the new build
sudo nixos-rebuild switch

######### UPGRADE ##########
# change to the new channel
sudo nix-channel --add https://channels.nixos.org/nixos-new_version nixos
# upgrade to it
# in one command
sudo nixos-rebuild switch --upgrade
# or in multiple commands
sudo nix-channel --update nixos
sudo nixos-rebuild switch
```

### Configuration file directories
```
~/.zshrc
~/.config/kitty/kitty.conf
~/.config/hypr/hyprland.conf
~/.config/hypr/hyprpaper.conf
/etc/nixos/configuration.nix
```

### Incorporate unstable nix packages
```bash
# view your current channels
sudo nix-channel --list
# add unstable channel
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
# update the system channels
sudo nix-channel --update
# upgrade to utilize the new packages
nixos-rebuild switch --upgrade
```

### Clear garbage
- Delete all previous nixos versions
```bash
sudo nix-collect-garbage -d
```
- Periodically delete previous nixos versions
```nix
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};
```

### Buttonless tasks
- Suspend (sleep)
```bash
systemctl suspend
```
