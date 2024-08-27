{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "highwind";
  time.timeZone = "America/Fortaleza";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  users.users.luis = {
    uid = 1000;
    isNormalUser = true;
    description = "luis";
    extraGroups = [
      "wheel"
    ];
    packages = with pkgs; [
      home-manager
    ];
  };

  home-manager.users.luis = import ./home.nix;
  environment.systemPackages = with pkgs; [
    nix-index
    drm_info
    pciutils
    tfswitch
    yarn2nix
    starship
    dnsmasq
    ripgrep
    weechat
    gnumake
    openssh
    fcitx5
    bundix
    cargo
    arion
    unzip
    gnupg
    lorri
    nomad
    vault
    ruby
    sddm
    sway
    rofi
    yarn
    xsel
    lshw
    htop
    nmap
    stow
    zlib
    wget
    curl
    gcc
    age
    git
    fzf
    dig
    vim
    vim
    git
    gh
    globalprotect-openconnect
    traceroute
    vim
    wget
    git
  ];

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.settings.PasswordAuthentication = true;
  services.dnsmasq.enable = true;
  services.dnsmasq.settings.server = [
    "1.1.1.1"
    "1.0.0.1"
    "8.8.8.8"
    "8.8.4.4"
  ];

  fonts.packages = with pkgs;[
    fira-code
    fira-code-symbols
  ];

  powerManagement.cpuFreqGovernor = "performance";

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = ${toString (1024 * 1024 * 1024)}
      max-free = ${toString (4096 * 1024 * 1024)}
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings.auto-optimise-store = true;
    package = pkgs.nixFlakes;
  };

  networking.firewall.enable = false;
  networking.firewall.extraCommands = ''
    ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

