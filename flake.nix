{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs =
    {
      nixpkgs,
      nix-flatpak,
      home-manager,
      plasma-manager,
      emacs-overlay,
      ...
    }@inputs:
    let
      commonImports = [
        ./home.nix
        ./home/zsh/zsh.nix
        ./home/emacs/emacs.nix
        ./home/vscode/vscode.nix
        ./home/kde/plasma.nix
        #./home/gnome/gnome.nix
        #./home/bash/bash.nix
      ];

      homeManagerConfig = {
        nixpkgs.overlays = [ emacs-overlay.overlay ];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
        home-manager.backupFileExtension = "backup";
        home-manager.users.slan = {
          imports = commonImports ++ [ ];
        };
      };
      
      commonModules = [
        #./modules/gnome.nix
        ./modules/flatpak.nix
        ./modules/kde.nix
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
