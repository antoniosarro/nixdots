{ pkgs, ... }:
{
  hardware.amdgpu.opencl.enable = true;
  hardware.amdgpu.amdvlk.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
  };

  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    acceleration = "rocm";
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1031";
    };
    rocmOverrideGfx = "10.3.1";
    host = "0.0.0.0";
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      11434
      8080
    ];
  };

  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
  };

}
