# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.grub = {
    enable = true; 
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "nixos"; # Define your hostname.
  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  
  # Enable the gnome Desktop Environment and the gdm Display Manager
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Set hyprland as the defauly session
  services.displayManager.defaultSession = "hyprland";

  ######## Window Manager ########
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  ########### Fonts ############
  # While the fonts were installed in the system packages list 
  # they have to be here too for the system apps to be able to utilize them.
  # Fonts help render certain icons, emojis, text, etc...
  fonts.packages = with pkgs; [
    nerdfonts
  ];
 
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # if you use pulseaudio with xfce
  nixpkgs.config.pulseaudio = true;
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kou = {
    isNormalUser = true;
    description = "kou";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      
    ];
  };
   
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Applications 
    firefox # Browser
    librewolf # Hardened browser
    thunderbird # Mail
    obsidian # Markdown notes
    vscode # IDE
    gimp # Image Editor
    vlc # Video and Audio Playback
    libreoffice # Office
    stremio # Movies and Tv-series
    kdePackages.kdenlive # video editor
    discord # messaging
    qbittorrent # torrenting
    filezilla # file access through ssh 
    flatpak # sandboxed applications 
    localsend # file sharing through wifi
    xournal # note-taking pdf annotating

    # Gaming
    steam # steam platform for games
    retroarch # retro console emulation
    goverlay # gui mangohud editing
    mangohud # fps temps etc
    virtualbox # pc emulation
    cpu-x # cpu info

    # Ricing
    hyprland # windows manager
    hyprpaper # wallpaper deamon
    hyprlock # lock screen
    rofi-wayland # app launcher
    waybar # top bar
    pamixer # audio mixer for waybar
    pavucontrol # audio options
    kitty # terminal
    neovim # editor
    nerdfonts # fonts
    bibata-cursors # cursor theme
    orchis-theme # desktop theme
    papirus-icon-theme # icon theme

    # Fun packages 
    figlet # ascii wordart
    neofetch # os details
    btop # resource monitor
    htop # process viewer
    pipes # terminal script
    cbonsai # terminal script
    gomatrix # terminal script
    cava # terminal audio visualizer

    # Utility Applications
    wget # download from command line
    git # version control
    unzip # unzipper
    dunst # notification deamon, dunst is x11 + wayland, mako is pure wayland
    wl-clipboard # clipboard
    grim # screenshot dep 1
    slurp # screenshot dep 2
    libnotify # dependency of notification deamon
    os-prober # for dual booting
    gptfdisk # gpt disk tool
    gcc14 # C programming language
    bc # synth shell dependency
    lm_sensors # synth shell dependency, read cpu temperatures
  ];

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}