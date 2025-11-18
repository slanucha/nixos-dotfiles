{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  programs.plasma = {
    enable = true;
  };
}
  
