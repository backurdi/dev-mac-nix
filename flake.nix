{
  description = "Bachir's portable development-only macOS configuration";

  inputs = {
    # Exact upstream commits captured on 2026-07-28. flake.lock adds content
    # hashes when generated, but these refs are already immutable.
    nixpkgs.url = "tarball+https://github.com/NixOS/nixpkgs/archive/329c3d2af6d1b618705150ea39f72c15eb4e613e.tar.gz";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/c3e90c89649b07d1a96e4b9dd6cd0d6e44b91a74";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/d4fd24667c8cbef124bb70a20380cab75ec8474d";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew/60623ec512406261f553d24033c8a0c53fd0b7f2";
  };

  outputs =
    inputs@{
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      ...
    }:
    let
      user = import ./user.nix;
    in
    {
      darwinConfigurations.dev-mac = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs user; };

        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          ./modules/system.nix
          ./modules/homebrew.nix

          {
            nix-homebrew = {
              enable = true;
              user = user.username;
              enableRosetta = false;
              autoMigrate = true;

              # Third-party taps are declared by nix-darwin. Keeping taps
              # mutable avoids adding every tap repository as a flake input.
              mutableTaps = true;
            };
          }

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-backup";
              extraSpecialArgs = { inherit inputs user; };
              users.${user.username} = import ./home/home.nix;
            };
          }
        ];
      };

      formatter.${user.system} = nixpkgs.legacyPackages.${user.system}.nixfmt-rfc-style;
    };
}
