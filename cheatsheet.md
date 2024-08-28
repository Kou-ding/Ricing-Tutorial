# Ricing Cheatsheet
### config files directories
~/.zshrc
~/.config/kitty/kitty.conf
~/.config/hypr/hyprland.conf
~/.config/hypr/hyprpaper.conf
/etc/nixos/configuration.nix
### Neovim
- i
> insert mode for text editing
- esc 
> exit to command mode
- :wq
> write and quit
- :q!
> quit
- u
> undo
- y, d, p 
> copy, cut, paste

> select word with keyboard
> 
### Hyprland navigation
- SUPER + arrowkey
> shift focus to adjacent window
- SUPER + C
> kill window
- SUPER + R
> open rofi app menu

### To-do
- file manager
- wtf not working

### Unstable nix packages
```zsh
sudo -i
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
nixos-rebuild switch --upgrade
```

### Clear garbage
```
sudo nix-collect-garbage -d
```

```nix
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};
```
### Buttonless tasks
- suspend
> systemctl suspend
