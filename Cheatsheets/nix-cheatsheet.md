# Nixos Cheatsheet

### Configuration file directories
```bash
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
