{ pkgs, config, lib, ...}:
let
  ghci = pkgs.haskellPackages.ghcWithPackages ( hpkgs: with hpkgs; [ tidal_1_8_0 ] );

  Qtile = import ./qtile-env.nix {
    inherit pkgs config lib;
    username = "quartus";
    home-manager-opts = {
      #systemd.user.services = {
      #  blocky = {
      #    Unit = {
      #      Description = "A DNS proxy ran under the VRT";
      #    };

      #    Install = {
      #      WantedBy = [ "multi-user.target" ];
      #    };

      #    Service = {
      #      ExecStart = "${pkgs.blocky}/bin/blocky --config ${blockyConfig}";

      #    };
      #  };
      #};
      home.packages = with pkgs; [
        quartus-prime-lite
      ];
    };
  };
in {
  inherit (Qtile) home-manager users fonts;

  containers = {
    blocky = {
      ephemeral = true;
      privateNetwork = true;
      hostAddress = "192.168.100.1";
      localAddress = "192.168.100.20";
      forwardPorts = [
        { containerPort = 53; hostPort = 53; protocol = "tcp"; }
        { containerPort = 4000; hostPort = 4000; protocol = "tcp"; }
      ];

      config = { pkgs, config, ...}: {
        system.stateVersion = "22.05";
        networking.firewall.allowedTCPPorts = [ 53 4000 ];
        services.blocky = {
          enable = true;
          settings = {
            port = "53";
            httpPort = "4000";
            logLevel = "info";

            upstream.default = [
              "1.1.1.1" "1.0.0.1"
            ];
            blocking = {
              whiteLists.ads = [
                ''
                duckduckgo.com
                stackoverflow.com
                sstatic.com
                ''
              ];
            };
          };
        };
      };
    };
  };
}
