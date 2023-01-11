{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
  inputs.nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;
  inputs.home-manager = {
    url = github:nix-community/home-manager/release-22.11;
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nixos-generators = {
    url = "github:nix-community/nixos-generators";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.vim-flake = {
    url = "path:software-flake/vim";
    flake = true;
  };

  outputs = { self, nixpkgs, nixos-generators, vim-flake, nixpkgs-unstable, ... }@attrs: {
    nixosConfigurations.loranix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration.nix ];
    };
#    nixosConfigurations.usbnix = nixpkgs.lib.nixosSystem {
#      system = "x86_64-linux";
#      specialArgs = attrs;
#      modules = [ ./configuration-usb.nix ];
#    };
#    packages.x86_64-linux = {
#      vmware = nixos-generators.nixosGenerate {
#        system = "x86_64-linux";
#        modules = [ ./configuration-usb.nix ];
#        format = "vmware";
#      };
#    };

  };
}
