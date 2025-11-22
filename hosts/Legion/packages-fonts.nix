# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config

{
  Mypkgs,
  pkgs,
  unstable-pkgs,
  inputs,
  ...
}:
let
  python-packages = pkgs.python3.withPackages (
    ps: with ps; [
      requests
      pyquery # needed for hyprland-dots Weather script

    ]
  );
in
{

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages   QYKw9umtV2HVDDZ5qnF8DuSxcuvR
    openssl
    curl
    zlib
    libssh2
    nghttp2
    pkg-config
    libGL
    glib

  ];
  environment.systemPackages =
    (with pkgs; [
      # System Packages
      bc
      rclone
      nil
      nixfmt-rfc-style
      go
      wpsoffice-cn
      qemu
      docker
      #lenovo-legion
      #rust toolchain
      rustup
      cudaPackages.cudatoolkit
      gh
      pgcli
      ntfs3g
      #pdf reader
      kdePackages.okular
      jdk
      iw
      zip
      android-tools
      nodejs_24
      #yazi
      filezilla
      rar
      termius
      gnumake
      telegram-desktop
      pkg-config
      minicom
      usbutils
      zlib
      micromamba
      cmake
      gcc
      gdb
      readline
      ncurses
      libffi
      zlib
      sqlite
      pyenv
      jetbrains.pycharm-professional
      uv
      kdePackages.ark
      baobab
      btrfs-progs
      clang
      curl
      cpufrequtils
      duf
      ffmpeg
      glib # for gsettings to work
      gsettings-qt
      git
      killall
      libappindicator
      libnotify
      openssl # required by Rainbow borders
      openssl.dev
      pciutils
      #vim
      wget
      xdg-user-dirs
      xdg-utils
      gparted
      fastfetch
      (mpv.override { scripts = [ mpvScripts.mpris ]; }) # with tray
      #ranger

      # Hyprland Stuff
      # (ags.overrideAttrs (oldAttrs: {
      #   inherit (oldAttrs) pname;
      #   version = "1.8.2";
      # }))
      ags
      btop
      inetutils
      brightnessctl # for brightness control
      cava
      cliphist
      loupe
      gnome-system-monitor
      grim
      gtk-engine-murrine # for gtk themes
      hyprcursor # requires unstable channel
      hypridle # requires unstable channel
      imagemagick
      inxi
      jq
      kitty
      libsForQt5.qtstyleplugin-kvantum # kvantum
      networkmanagerapplet
      nwg-displays
      nwg-look # requires unstable channel
      nvtopPackages.panthor
      pamixer
      pavucontrol
      playerctl
      polkit_gnome
      #pyprland
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum # kvantum
      rofi-wayland
      slurp
      swappy
      swaynotificationcenter
      swww
      unzip
      wallust
      wl-clipboard
      wlogout
      #xarchiver
      yad
      wireshark
      obs-studio
      protobuf
      #waybar  # if wanted experimental next line
      #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
      #zsh theme
      spaceship-prompt
    ])
    ++ [
      python-packages
    ]
    ++ (with unstable-pkgs; [
      yazi
      vscode-fhs
      codex
      wechat
      qq
      baidupcs-go
    ]);

  # FONTS
  fonts.packages = with pkgs; [
    SF-Pro
    PingFang
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
    terminus_font
    victor-mono
    # (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    # (nerdfonts.override {fonts = ["FantasqueSansMono"];}) # stable banch
    nerd-fonts.jetbrains-mono # 25.05 change
    nerd-fonts.fira-code # 25.05 change
    nerd-fonts.fantasque-sans-mono # 25.05 change
  ];
}
