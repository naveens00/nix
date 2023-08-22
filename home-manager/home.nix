# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  self,
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  mapPrefixPath = prefix: map (x: "${prefix}/${x}");
in {
  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "naveen";
    homeDirectory = "/Users/naveen";
  };

  imports = mapPrefixPath (self + /home-manager/modules) [
    "terminal.nix"
    "neovim.nix"
    #"python.nix"
  ];

  # Allow home-manager to install fonts
  fonts.fontconfig.enable = true;

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    # Command line applications
    neofetch
    bat
    tree
    # Nix
    nixfmt
    # Fonts
    noto-fonts-emoji
    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  programs.starship.enable = true;
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
