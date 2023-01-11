{ config, pkgs, ... } :

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
  '';
in
{
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" "displaylink" ];
  hardware.opengl.enable = true;

  environment.systemPackages = [ nvidia-offload ];
  hardware.nvidia.prime = {
    offload.enable = true;

    intelBusId = "PCI:0:2:0";

    nvidiaBusId = "PCI:1:0:0";
  };
}
