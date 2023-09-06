{ self, inputs, outputs, lib, config, pkgs, ... }:
{
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

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    neofetch
    bat
    tree

    # Fonts
    noto-fonts-emoji
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.zsh.enable = true;

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
  
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
