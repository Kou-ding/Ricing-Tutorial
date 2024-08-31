# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  ############ Bootloader ############
  # Default Bootloader
  #boot.loader.systemd-boot.enable = true;
  # Grub Bootloader
  boot.loader.grub = {
    enable = true; 
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
 
  ####### Login manager ########
  # Enables the X11 windowing system
  services.xserver.enable = true;
  # Minimal login screen that launches Hyprland on start up
  # Hyprland executes hyprlock and make it our login screen
  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "kou";
      };
      initial_session = {
        command = "Hyprland";
        user = "kou";
      };
    };
  }; 

  ######### Lock screen ##########
  # Hyperlock
  programs.hyprlock.enable = true;

  ######## Window Manager ########
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  ########### Fonts ############
  # While the fonts were installed in the system packages list 
  # they have to be here too for the system apps to be able to utilize them.
  # Fonts help render certain icons, emojis, text, etc...
  fonts.packages = with pkgs; [
    nerdfonts
  ];
  
  ########## Theme #########
  qt.enable = true;
  qt.platformTheme = "gnome";
  qt.style = "adwaita-dark";
  # Force Adwaita Dark for GNOME applications
  environment.sessionVariables.GTK_THEME = "Adwaita:dark";

  # Desktop portals handle program interactions, screensharing, link opening, file opening etc...
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
 
  ######## Basic configuration ########
  # The same stuff someone would choose inside an installer
  # hostname
  networking.hostName = "nixos"; # Define your hostname.

  # Enables wireless support via wpa_supplicant.
  # networking.wireless.enable = true; 

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
    LC_ADDRESS = "el_GR.UTF-8";
    LC_IDENTIFICATION = "el_GR.UTF-8";
    LC_MEASUREMENT = "el_GR.UTF-8";
    LC_MONETARY = "el_GR.UTF-8";
    LC_NAME = "el_GR.UTF-8";
    LC_NUMERIC = "el_GR.UTF-8";
    LC_PAPER = "el_GR.UTF-8";
    LC_TELEPHONE = "el_GR.UTF-8";
    LC_TIME = "el_GR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  ############### User ##################
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kou = {
    isNormalUser = true;
    description = "kou";
    shell = pkgs.bash;
    extraGroups = [ "networkmanager" "video" "input" "wheel" ];
    packages = with pkgs; [];
  };

  ################## Packages #####################
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Basic Applications 
    firefox # Browser
    xfce.thunar # File explorer
    swappy # Image Viewer

    # Optional Applications
    obsidian # Markdown notes
    vscode # IDE
    gimp # Image Editor
    vlc # Video and Audio Playback
    libreoffice # Office
    stremio # Movies and Tv-series
    kdePackages.kdenlive # video editor
    discord # messaging
    qbittorrent # torrenting

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
    adwaita-qt # theme
    
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
    dunst # notification deamon, dunst is x11 + wayland, mako is pure wayland
    wl-clipboard # clipboard
    grim # screenshot dep 1
    slurp # screenshot dep 2
    libnotify # dependency of notification deamon
    os-prober # for dual booting
    libsForQt5.qt5.qtquickcontrols2 # sddm dep 1
    libsForQt5.qt5.qtgraphicaleffects # sddm dep 2
    gptfdisk # gpt disk tool
    gcc14 # C programming language

    libsForQt5.sddm-kcm
    gtk3  # For Adwaita theme
    gnome.adwaita-icon-theme # The Adwaita theme icons 
    gsettings-desktop-schemas # settings for gnome applications
    greetd.greetd # simple login manager
    greetd.tuigreet # simple login manager
    nwg-look # gtk theme picker, mainly for selecting a cursor out of all the downloaded ones
  ];
  
  # Override Attributes making sure waybar works
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  ############# Sound #############
  # Enable sound with pipewire
  # sound.enable = true; # no longer needed
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable  = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  ########## Services ##########
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  ######### Firewall ##########
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  ######################### NIXOS VERSION ##########################
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
