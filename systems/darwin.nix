{ inputs, username }: (system:
#let
#  system-config = import ../module/configuration.nix;
#  home-manager-config = import ../module/home-manager.nix;
#in
inputs.darwin.lib.darwinSystem {
  inherit system;
  modules = [
    {
      # minimum required settings
      users.users.${username}.home = "/Users/${username}";
      services.nix-daemon.enable = true;
      programs.zsh.enable = true; # add nix to path while using zsh
    }

    "${inputs.self}/modules/configuration.nix"

    inputs.home-manager.darwinModules.home-manager
    {
      # add home-manager settings here
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users."${username}" = "${ inputs.self }/modules/home-manager/home.nix";
    }
  ];
})
