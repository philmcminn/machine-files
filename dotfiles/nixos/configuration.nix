# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      <nixos-hardware/framework/13-inch/amd-ai-300-series>
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set the machine's host name.
  networking.hostName = "willow-warbler"; # Define your hostname.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.phil = {
    isNormalUser = true;
    description = "Phil McMinn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # ...
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  
    # Browsers
    brave
    firefox

    # Cloud
    pcloud

    # GNOME extras
    gnomeExtensions.dash-to-dock # TODO: doesn't seem to work for me.
    gnomeExtensions.forge
        
    # Latex
    texlive.combined.scheme-full

    # Media
    spotify

    # Note-taking
    obsidian

    # PDF reading and viewing
    zathura
      zathuraPkgs.zathura_pdf_poppler # PDF support/back-end
    zotero

    # Programming languages
    python3
    ruby
      bundler

    # Shell
    eza    
    fd
    gcc
    ghostty
    starship
    wl-clipboard
    yazi  
    zsh-completions
    zsh-fzf-history-search
    zsh-history-substring-search
    zsh-vi-mode
    zsh-you-should-use

    # Text editors
    neovim
    vscode

    # Version control
    git
    lazygit
  ];

  # Zsh
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    interactiveShellInit = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  };  



  programs.starship = {
    enable = true;
  };

  
  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    maple-mono.NF
    maple-mono.Normal-NF
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    nerd-fonts.monaspace
    nerd-fonts.roboto-mono
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


  # Configure automatic garbage collection for NixOS state;
  # this controls the number of generations that are kept
  # inside of the Nix store and thus the number of system
  # configurations that are available for selection at boot
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 60d";
    randomizedDelaySec = "1 hour";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
