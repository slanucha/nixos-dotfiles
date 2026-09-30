{ inputs, lib, pkgs, ... }:

{
  # Enable Niri system-wide
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
  };

  # Configure DankMaterialShell under Home Manager
  home-manager.users.slan = {
    imports = [ inputs.dms.homeModules.dank-material-shell ];

    programs.dank-material-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
    
    home.packages = with pkgs; [
      xwayland-satellite
    ];

    systemd.user.services.dms.Install.WantedBy = lib.mkForce [ "niri.service" ];
  };

}
