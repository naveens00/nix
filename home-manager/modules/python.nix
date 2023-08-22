{ self, inputs, outputs, lib, config, pkgs, ... }: {
  home.packages = with pkgs; [ python3 black poetry ];
}
