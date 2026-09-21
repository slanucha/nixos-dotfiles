{ config, pkgs, ... }:

{
  services.flatpak.packages = [
    "ch.protonmail.protonmail-bridge"
  ];
}
