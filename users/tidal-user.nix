{ pkgs, config, lib, ...}:
let
  ghci = pkgs.haskellPackages.ghcWithPackages ( hpkgs: with hpkgs; [ tidal_1_8_0 ] );

  format = pkgs.formats.yaml {};
  blockyConfig = format.generate "config.yaml" ''
    customDNS:
      rewrite:
        google.com: duckduckgo.com
  '';

  Qtile = import ./qtile-env.nix {
    inherit pkgs config lib;
    username = "tidal";
    home-manager-opts = {
      home.packages = with pkgs; [
        ghci
        supercollider-with-plugins
        haskellPackages.tidal_1_8_0
        

      ];
    };
  };
in
{
  inherit (Qtile) home-manager users fonts; 

  security.sudo.extraConfig = ''
    tidal ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl
  '';
}
