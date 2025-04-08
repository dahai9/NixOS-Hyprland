# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config

{ Mypkgs, pkgs, unstable-pkgs, inputs, ... }:
let
  python-packages = pkgs.python3.withPackages (ps:
    with ps; [
      requests
      pyquery # needed for hyprland-dots Weather script
      pip
    ]);
in {

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages   QYKw9umtV2HVDDZ5qnF8DuSxcuvR
  ];
  environment.systemPackages = (with pkgs; [
    # System Packages
    bc
    
    rclone
    #lenovo-legion
    #rust toolchain
    rustup
    #pdf reader
    kdePackages.okular
    
    iw
    zip
    android-tools
    nodejs_23
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

    #waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [ 
    python-packages 
  ]++(with unstable-pkgs; [
      yazi
      vscode
      
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
    (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    (nerdfonts.override {fonts = ["FantasqueSansMono"];}) # stable banch
    #nerd-fonts.jetbrains-mono # unstable 
    #nerd-fonts.fira-code # unstable
    #nerd-fonts.fantasque-sans-mono #unstable
  ];
}
