# flake.nix - Updated with hostname "nixos"
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, lanzaboote, ... }@inputs:
    let
      user = "matt";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      secrets = import ./secrets.nix;
    in
    {
      # == NixOS System Configuration ==
      nixosConfigurations = {
        # The hostname has been changed here
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs user secrets; };
          modules = [
            lanzaboote.nixosModules.lanzaboote
            ./system/configuration.nix
          ];
        };
      };

      # == Home Manager User Configuration ==
      homeConfigurations = {
        ${user} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs user secrets; };
          modules = [
            ./config/home.nix 
          ];
        };
      };
    };
}
