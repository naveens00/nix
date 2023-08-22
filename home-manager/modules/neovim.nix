{ self, inputs, outputs, lib, config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    # extraPackages = with pkgs; [ nodejs ];
  };

  xdg.configFile.nvim = {
    source =
      config.lib.file.mkOutOfStoreSymlink "${self}/home-manager/dotfiles/nvim";
    recursive = true;
  };
}
