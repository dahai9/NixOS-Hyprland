{ lib, pkgs, ... }:
{
  services.mihomo.enable = true;
  services.mihomo.configFile = "/home/dahai003/.config/mihomo/config.yaml";
  services.mihomo.tunMode = true;
  services.mihomo.webui = pkgs.metacubexd;
  #services.teamviewer.enable = true;
  systemd.services.mihomo = {
    wantedBy = lib.mkForce [ ]; # 禁用开机自启动
  };
  # systemd.services.mihomo = {
  #   description = "mihomo Daemon, Another Clash Kernel";
  #   after = [ "network.target" "NetworkManager.service" "systemd-networkd.service" "iwd.service" ];
  #   serviceConfig = {
  #     LimitNPROC = 500;
  #     LimitNOFILE = 1000000;
  #     CapabilityBoundingSet = [
  #       "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH CAP_DAC_OVERRIDE"
  #     ];
  #     AmbientCapabilities = [
  #       "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH CAP_DAC_OVERRIDE"
  #     ];
  #     Restart = "always";
  #     ExecStartPre = "${pkgs.coreutils}/bin/sleep 1s";
  #     ExecStart = "${pkgs.mihomo}/bin/mihomo -d /home/dahai003/.config/mihomo";
  #     ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
  #   };
  # };

  systemd.services.rclone-onedrive-mount = {
    description = "Service that connects to Google Drive";
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig =
      let
        riveDir = "/home/Onedrive"; # 你的Google Drive挂载目录
      in
      {
        Type = "simple";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${riveDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full Onedrive: ${riveDir} --vfs-cache-max-size 15G --allow-other";
        ExecStop = "/run/current-system/sw/bin/fusermount -u ${riveDir}";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
        User = "dahai003";
      };
  };
  systemd.services.rclone-sync-mount = {
    description = "Service that connects to Google Drive";
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig =
      let
        riveDir = "/home/Sync"; # 你的Google Drive挂载目录
      in
      {
        Type = "simple";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${riveDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full Sync: ${riveDir} --vfs-cache-max-size 15G --allow-other";
        ExecStop = "/run/current-system/sw/bin/fusermount -u ${riveDir}";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
        User = "dahai003";
      };
  };
  # systemd.services.rclone-onedrive = {
  #   description = "Mount OneDrive with rclone";
  #   after = [ "network-online.target" ];  # 网络可用后启动
  #   #wantedBy = [ "multi-user.target" ];  # 默认开机启动
  #   serviceConfig = {
  #     ExecStart = "${pkgs.rclone}/bin/rclone mount Onedrive:/ /home/Onedrive --vfs-cache-mode writes --vfs-cache-max-size 15G --allow-other ";
  #     ExecStop = "${pkgs.fuse}/bin/fusermount -uz /home/Onedrive";
  #     # Restart = "on-failure";  # 仅在失败时重启
  #     # RestartSec = "10s";       # 重启间隔5秒
  #     # StartLimitInterval = "60s";  # 限制重启计数的时间窗口
  #     # StartLimitBurst = 3;     # 最多尝试三次
  #     User = "dahai003";  # 替换为你的用户名
  #   };
  # };

  # usbmuxd service cofig
  services.usbmuxd = {
    enable = true;
  };
  users.users.usbmux.extraGroups = [ "docker" ];
}
