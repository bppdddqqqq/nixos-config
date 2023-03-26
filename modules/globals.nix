{
  pkgs,
  config,
  ...
}: {
  # nix settings
  nixpkgs.config.allowUnfree = true;
  # android sdk
  nixpkgs.config.android_sdk.accept_license = true;
  # dedupe
  nix.settings.auto-optimise-store = true;
  # nix flakes activation
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # default shell is FISH
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [fish];

  # enable documentation
  documentation.dev.enable = true;

  # fonts!
  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
    #    google-fonts
  ];

  # clean logs older than 2d
  services.cron.systemCronJobs = [
    "0 20 * * * root journalctl --vacuum-time=2d"
  ];

  # set state version
  system.stateVersion = "22.11";
}
