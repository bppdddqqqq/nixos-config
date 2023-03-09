{
  pkgs,
  config,
  ...
}: {
  # enables docker
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
  virtualisation.docker.enable = true;
}