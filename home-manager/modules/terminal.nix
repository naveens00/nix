{ inputs, outputs, lib, config, pkgs, ... }: {
  # Wezterm
  programs.wezterm.enable = true;
  xdg.configFile."wezterm".source = ../dotfiles/wezterm;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
}
