# Run neofetch at startup
neofetch

# Create aliases
alias update='sudo -E nvim /etc/nixos/configuration.nix'
alias upgrade='sudo nixos-rebuild switch'


##-----------------------------------------------------
## synth-shell-greeter.sh
#if [ -f /home/kou/.config/synth-shell/synth-shell-greeter.sh ] && [ -n "$( echo $- | grep i )" ]; then
#	source /home/kou/.config/synth-shell/synth-shell-greeter.sh
#fi

##-----------------------------------------------------
## synth-shell-prompt.sh
if [ -f /home/kou/.config/synth-shell/synth-shell-prompt.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/kou/.config/synth-shell/synth-shell-prompt.sh
fi

##-----------------------------------------------------
## better-ls
if [ -f /home/kou/.config/synth-shell/better-ls.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/kou/.config/synth-shell/better-ls.sh
fi

##-----------------------------------------------------
## alias
if [ -f /home/kou/.config/synth-shell/alias.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/kou/.config/synth-shell/alias.sh
fi

##-----------------------------------------------------
## better-history
if [ -f /home/kou/.config/synth-shell/better-history.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/kou/.config/synth-shell/better-history.sh
fi