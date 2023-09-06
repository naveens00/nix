{ inputs, username }: (system:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.${ system };
  modules = [
    "${ inputs.self }/modules/home-manager/home.nix"
  ];
})

