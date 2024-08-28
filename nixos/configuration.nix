# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader
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

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
 
  # sddm Desktop manager
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
  };

  # KDE Plasma Display manager
  #services.desktopManager.plasma6.enable = true;
  #services.displayManager.defaultSession = "plasma";
 
  # Hyprland Window Manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  }; 

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kou = {
    isNormalUser = true;
    description = "kou";
    shell = pkgs.bash;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
 
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Applications 
    firefox-wayland # browser
    obsidian # markdown notes
    vscode # ide
    gimp # image editor
    vlc # video and audio playback
    libreoffice # office

    # kde apps
    kdePackages.gwenview # image viewer
    kdePackages.dolphin # file manager
    kdePackages.kdenlive # video editor

    # Ricing
    hyprland # windows manager
    hyprpaper # wallpaper deamon
    rofi-wayland # app launcher
    waybar # top bar
    pamixer # audio mixer for waybar
    pavucontrol # audio options
    kitty # terminal
    neovim # editor
    adwaita-qt # theme
    
       
    # Fun packages
    figlet # ascii wordart
    neofetch # os details
    btop # resource monitor
    htop # process viewer

    #Utility Apps
    home-manager
    wget # download from command line
    git # version control
    dunst # notification deamon, dunst is x11 + wayland, mako is pure wayland
    libnotify # dependency of notification deamon
    os-prober # for dual booting
    libsForQt5.qt5.qtquickcontrols2 # sddm dep 1
    libsForQt5.qt5.qtgraphicaleffects # sddm dep 2
    gptfdisk
  ];
  
  # make sure waybar works
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  # Fonts to render certain text
  fonts.packages = with pkgs; [
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  
  # Theme
  qt.enable = true;
  qt.platformTheme = "qt5ct";
  #qt.platformTheme.name= "gtk";
  qt.style = "adwaita-dark";
 
  # Desktop portals handle program interactions, screensharing, link opening, file opening etc...
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
