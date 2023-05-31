{ config
, pkgs
, nix-vscode-extensions
, ...
}:
let
  overlay-extensions = nix-vscode-extensions.overlays.default;
in
{
  nixpkgs.overlays = [ overlay-extensions ];
}
