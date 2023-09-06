{
  description = "Naveen´s Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @{ self, nixpkgs, home-manager, darwin, ... }:
    let
      username = "naveen";

      darwin-system = import ./systems/darwin.nix { inherit inputs username; };
      # nixos-system = import ./systems/nixos.nix { inherit inputs username; };
      hm-standalone-system = import ./systems/system-agnostic.nix { inherit inputs username; };

      inherit (self) outputs;

      appleSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      linuxSystems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
      ];
      allSystems = linuxSystems ++ appleSystems;
      forSystems = (systemList: nixpkgs.lib.genAttrs systemList);
    in
    {
      homeConfigurations = { 
        aarch64-darwin = hm-standalone-system "aarch64-darwin" ;
        x86_64-darwin = hm-standalone-system "x86_64-darwin" ;
        aarch64-linux = hm-standalone-system "aarch64-linux";
        i686-linux = hm-standalone-system "i686-darwin";
        x86_64-linux = hm-standalone-system "x86_64-linux";
      };

      darwinConfigurations = {
        aarch64-darwin = darwin-system "aarch64-darwin";
        x86_64-darwin = darwin-system "x86_64-darwin";
      };

      formatter = forSystems allSystems (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      devShells =
        forSystems allSystems (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = pkgs.mkShell {
              # avoid shadowing of home-manager (`with` can get shadowed)
              nativeBuildInputs = (with pkgs; [ nix git ]) ++ [ pkgs.home-manager ];
              NIX_CONFIG = "experimental-features = nix-command flakes";
              shellHook = ''
                	echo "Entered shell for bootstrapping flake-enabled nix"
              '';
            };
          });
    };
}
