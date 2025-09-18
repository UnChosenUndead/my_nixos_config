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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.blueman.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  security.polkit.enable = true;
  services.flatpak.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services = {
   desktopManager.plasma6.enable = true;
   displayManager.sddm.enable = true;
   displayManager.sddm.wayland.enable = true; 
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user23 = {
    isNormalUser = true;
    description = "Stanislav";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alsa-lib.dev
    udev.dev
    udev 
    alsa-lib-with-plugins
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXi 
    xorg.libXrandr # To use the x11 feature
    libxkbcommon
    wayland # To use the wayland feature
    git
    bluez-tools
    bluez
    go
    gcc
    libtool
    systemd
    wasm-bindgen-cli_0_2_100
    pkg-config
    gobject-introspection
    cargo 
    cargo-tauri
    at-spi2-atk
    atkmm
    cairo
    gdk-pixbuf
    glib
    gtk3
    harfbuzz
    librsvg
    libsoup_3
    pango
    webkitgtk_4_1
    openssl
    nodejs_24
    dioxus-cli
    cargo-binstall
    rustfmt
    rustc
    rustup
    nix-index
    polkit
    telegram-desktop
    kdePackages.bluedevil
    kdePackages.kde-cli-tools
    kdePackages.kdesu
    kdePackages.discover
    kdePackages.kcalc
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdePackages.kdeconnect-kde
    kdiff3
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    electron-bin
    wget
    links2
    firefox
    brave
    vscode
    vscode-extensions.ms-vscode.cpptools-extension-pack
    cmakeWithGui
    libgcc
    gnumake
    ninja
    blender
    gimp3-with-plugins
    android-tools
    wezterm
    appimage-run
    sfml
    sfml_2
  ];
  
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };    

  hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      # Shows battery charge of connected devices on supported
      # Bluetooth adapters. Defaults to 'false'.
      Experimental = true;
      # When enabled other devices can connect faster to us, however
      # the tradeoff is increased power consumption. Defaults to
      # 'false'.
      FastConnectable = true;
    };
    Policy = {
      # Enable all controllers when they are found. This includes
      # adapters present on start as well as adapters that are plugged
      # in later on. Defaults to 'true'.
      AutoEnable = true;
     };
   };
  };  

  nixpkgs.config.permittedInsecurePackages = [
   "electron-25.9.0"
  ];
  
  security.sudo.enable = true;
  
 
  environment.sessionVariables = {
    PKG_CONFIG_PATH = [
      "${pkgs.alsa-lib}/lib/pkgconfig"
      "${pkgs.pkg-config}/lib/pkgconfig"
      "${pkgs.systemd}/lib/pkgconfig"
    ];
    PKG_CONFIG_ALLOW_SYSTEM_LIBS = "1";
    PKG_CONFIG_ALLOW_SYSTEM_CFLAGS = "1";
    LD_LIBRARY_PATH = "/usr/lib:/usr/local/lib:/opt/custom/lib";
    PATH="/home/user23/.cargo/bin";
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
  system.stateVersion = "25.05"; # Did you read the comment?

}
