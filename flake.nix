{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs =
    {
      nixpkgs,
      nix-flatpak,
      home-manager,
      emacs-overlay,
      ...
    }@inputs:
    let
      commonImports = [
        ./home.nix
        ./modules/apps/gnome/gnome.nix
        ./modules/apps/bash/bash.nix
        ./modules/apps/emacs/emacs.nix
      ];

      homeManagerConfig = {
        nixpkgs.overlays = [ emacs-overlay.overlay ];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.slan = {
          imports = commonImports ++ [ ];
        };
      };
      
      commonModules = [
        ./modules/gnome.nix
        nix-flatpak.nixosModules.nix-flatpak
        home-manager.nixosModules.home-manager
        homeManagerConfig
      ];
    in
    {
      nixosConfigurations = {
        aorus = nixpkgs.lib.nixosSystem {
          modules = commonModules ++ [ ./hosts/aorus/configuration.nix ];
        };

        thinkpad = nixpkgs.lib.nixosSystem {
          modules = commonModules ++ [ ./hosts/thinkpad/configuration.nix ];
        };
      };
    };
}
