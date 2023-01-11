{ pkgs }:
with pkgs;
writeTextDir "coc-settings.json" ''
  {
    "languageserver": {
      "nix": {
        "command": "${nil}/bin/nil",
        "filetypes": ["nix"],
        "rootPatterns":  ["flake.nix"],
        "settings": {
          "nil": {
            "formatting": { "command": ["${nixpkgs-fmt}/bin/nixpkgs-fmt"] }
          }
        }
      }
    }
  }
''
