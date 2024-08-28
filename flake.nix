{
  description = "A very basic flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      inherit (self) outputs;
      specialArgs = {
        inherit outputs;
      };
      extraSpecialArgs = specialArgs;
    in
    {

      packages. x86_64-linux. hello = nixpkgs.legacyPackages.x86_64-linux.hello;

      packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

      homeManagerModules = import ./modules/home-manager;

      homeConfigurations = {
        luis = home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs;
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            home-manager.modules.home-manager
            ./home.nix
          ];
        };
      };

      nixosConfigurations = {
        plo = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            /etc/nixos/configuration.nix
            /etc/nixos/local-config.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
