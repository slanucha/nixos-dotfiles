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
        ./app/gnome/gnome.nix
        ./app/bash/bash.nix
        ./app/emacs/emacs.nix
      ];
    in
    {
      nixosConfigurations = {

        aorus = nixpkgs.lib.nixosSystem {
          modules = [
            ./host/aorus/configuration.nix
            ./desktop/gnome.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.slan = {
                imports = commonImports ++ [ ];
              };
            }
          ];
        };

        thinkpad = nixpkgs.lib.nixosSystem {
          modules = [
            ./host/thinkpad/configuration.nix
            ./desktop/gnome.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.slan = {
                imports = commonImports ++ [ ];
              };
            }
          ];
        };

      };
    };
}
