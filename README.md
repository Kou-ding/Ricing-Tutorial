# Ricing-Tutorial
A tutorial on unix systems customization aka ricing.
### To do list
- [ ] Test if the command line only version works!
- [ ] 

### Automatic installation
1. Install nixos via the graphical installer
2. git clone repo
3. cd /repo
4. run the sysconfig.sh script

### Manual installation 
1. Install nixos via the graphical installer
2. Copy paste the configuration.nix file inside the correct folder (/etc/nixos/configuration.nix)
3. run:
```bash
sudo nixos-rebuild switch
```
4. Copy paste all the necessary config files of this repo inside the corresponding firectories inside ~/.config/name_of_the_app/name_of_the_app.conf

External Sources
----------------
- https://github.com/mylinuxforwork/dotfiles
- 
