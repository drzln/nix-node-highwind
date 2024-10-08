{ config, pkgs, ... }:

{
  imports = [
    ./modules/home-manager/blackmatter
  ];

  nixpkgs.config.allowUnfree = true;
  home.username = "luis"; # Replace with your actual username
  home.homeDirectory = "/home/luis"; # Replace with your home directory

  # Set the state version to match Home Manager version
  home.stateVersion = "24.05"; # Use the correct version for your setup

  # Enable some basic packages
  home.packages = with pkgs; [
    vim
    nmap
    zsh
    poetry
  ];

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
  blackmatter.programs.nvim.enable = false;
  blackmatter.shell.enable = false;
  # home.file.".config/sheldon/plugins.toml".source = ./sheldon/plugins.toml;
}
