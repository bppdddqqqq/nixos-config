{
  pkgs,
  config,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # diagnostic tools
    nvme-cli
    smartmontools
    
    ncdu_2
    smartmontools
    lm_sensors
    
    unrar
    p7zip
    zip
    unzip
    tmux
    
    # code quality stuff for nix
    nixpkgs-fmt

    # python
    python3Full
    python310Packages.pip

    # basic dev tools
    git
    wget
    tldr
    yq-go
  ];
}
