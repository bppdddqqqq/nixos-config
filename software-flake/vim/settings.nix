{ pkgs ? <nixpkgs>, suffix ? "" }:
let
  inherit (builtins) readDir readFile mapAttrs;
  inherit (pkgs.lib) concatStrings attrValues hasSuffix;
  configsDir = readDir ./configs;
  configsRaw = concatStrings (attrValues (mapAttrs
    (name: x:
      if (x == "regular" && (hasSuffix suffix name)) then
        readFile (./configs + ("/" + name))
      else
        "")
    configsDir));
in
configsRaw
