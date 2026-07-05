{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.ktorrent
  ];

  programs.plasma = {
    enable = true;
  };
}
