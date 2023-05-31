{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs, ... }@attrs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.python310.withPackages (ps: with ps; [
      ]);
    in
    {
      devShells."${system}".default = pkgs.mkShell {
        packages = with pkgs; [
          nodejs-16_x
          nodePackages.npm
          python
        ];
      };
    };
}
