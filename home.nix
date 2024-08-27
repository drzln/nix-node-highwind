{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.username = "luis"; # Replace with your actual username
  home.homeDirectory = "/home/luis"; # Replace with your home directory

  # Set the state version to match Home Manager version
  home.stateVersion = "24.05"; # Use the correct version for your setup

  # Enable some basic packages
  home.packages = with pkgs; [
    vim
    git
    git-remote-gcrypt
    coreutils-prefixed
    gnirehtet
    yq-go
    unzip
    opam
    python3
    mysql
    tfsec
    ruby
    tfplugindocs
    tfswitch
    golint
    docker
    delve
    tree
    yarn
    typescript
    lazydocker
    # rnix-lsp
    # nixopsUnstable
    # postgres_with_libpq
    lazygit
    packer
    dig
    nmap
    saml2aws
    gcc
    jdk
    cargo
    ripgrep
    podman-compose
    tree
    sshfs
    php81Packages.composer
    php81Packages.php-cs-fixer
    xorriso
    traceroute
    iproute2
    sheldon
    python39Packages.pipenv-poetry-migrate
    python39Packages.poetry-core
    black
    pipenv
    poetry
    zlib
    awscli2
    goreleaser
    go-task
    gofumpt
    gobang
    go
    terraform-ls
    tflint
    terraform-docs
    terraform-landscape
    terraform-compliance
    kubectl
    sumneko-lua-language-server
    luarocks
    lua
    php
    redis-dump
    redis
    redli
    solargraph
    rbenv
    cargo-edit
    rust-code-analysis
    rust-analyzer
    rust-script
    rustic-rs
    rust-motd
    rusty-man
    rustscan
    rustfmt
    rustcat
    rustc
    sops
    age
    shfmt
    tealdeer
    himalaya
    tree-sitter
    yt-dlp
    tig
    grex
    skim
    gdb
    bat
    feh
    fd
    sd
    hyperfine
    bandwhich
    json2hcl
    node2nix
    cpulimit
    nushell
    ansible
    openssl
    gradle
    trunk
    whois
    delta
    tokei
    zoxide
    httpie
    xclip
    procs
  ];

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  home.file.".config/sheldon/plugins.toml".source = ./sheldon/plugins.toml;
  home.file."code".source = null;
}
