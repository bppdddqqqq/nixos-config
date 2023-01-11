{
  pkgs,
  config,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [fish];
  documentation.dev.enable = true;
  system.stateVersion = "22.11"; # Did you read the comment?

  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
    google-fonts
  ];
}
