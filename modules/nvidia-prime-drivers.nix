# 💫 https://github.com/JaKooLit 💫 #

{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.drivers.nvidia-prime;
in
{
  options.drivers.nvidia-prime = {
    enable = mkEnableOption "Enable Nvidia Prime Hybrid GPU Offload";
  };

  config = mkIf cfg.enable {
        hardware.nvidia.prime = {
                offload = {
                        enable = true;
                        enableOffloadCmd = true;
                };
                # Make sure to use the correct Bus ID values for your system!
                # intelBusId = "PCI:6::0";
                nvidiaBusId = "PCI:1:0:0";
                amdgpuBusId = "PCI:6:0:0"; #For AMD GPU
        };
 };
}
