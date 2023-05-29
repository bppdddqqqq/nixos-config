{ config, pkgs, nur, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import nur {
      inherit pkgs;
      nurpkgs = pkgs;
    };
  };
}
