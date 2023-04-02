{
  pkgs,
  config,
  ...
}: {
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    ignoreIP = [
      "127.0.0.0/8"
      "192.168.0.0/16"
      "147.251.0.0/16"
      "8.8.8.8"
      "8.8.4.4"
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}