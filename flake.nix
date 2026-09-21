{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # emacs-overlay.url = "github:nix-community/emacs-overlay";

    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-flatpak,
      home-manager,
      plasma-manager,
      # emacs-overlay,
      ...
    }@inputs:
    let
      commonImports = [
        ./home.nix
        ./home/nixvim/nixvim.nix
        ./home/vscode/vscode.nix
        ./home/wezterm/wezterm.nix
        ./home/zsh/zsh.nix
        #./home/bash/bash.nix
        #./home/emacs/emacs.nix
      ];

      homeManagerConfig = {
        #nixpkgs.overlays = [ emacs-overlay.overlay ];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.slan = {
          imports = commonImports ++ [ inputs.nix-doom-emacs-unstraightened.homeModule inputs.nixvim.homeModules.nixvim ];
        };
      };
      
      commonModules = [
        ./module/flatpak.nix
        nix-flatpak.nixosModules.nix-flatpak
        home-manager.nixosModules.home-manager
        homeManagerConfig
      ];

    in
    {
      nixosConfigurations = {
        aorus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = commonModules ++ [
            ./desktop/gnome.nix
            ./desktop/niri.nix
            ./host/aorus/configuration.nix ];
        };

        thinkpad = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = commonModules ++ [
            ./desktop/kde.nix
            ./host/thinkpad/configuration.nix ];
        };
      };
    };
}
