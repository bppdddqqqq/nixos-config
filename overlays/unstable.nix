{ config, pkgs, nixpkgs-unstable, ... }:
let
  system = pkgs.system;
  overlayA = final: prev: {
    unstable = import nixpkgs-unstable {
      inherit system;
      config = { allowUnfree = true; };
    };
  };
in { nixpkgs.overlays = [ overlayA ]; }
