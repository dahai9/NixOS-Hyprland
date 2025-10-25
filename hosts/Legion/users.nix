# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only

{
  pkgs,
  unstable-pkgs,
  username,
  ...
}:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users.extraGroups.plugdev.members = [ "dahai003" ];
  users = {
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "usbmux"
        "docker"
        "wireshark"
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
        "dialout"
      ];

      # define user packages here
      packages = with unstable-pkgs; [

        #kdePackages.kate
        #  thunderbird

        # mihomo-party

      ];
    };

    defaultUserShell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    lsd
    fzf
  ];

  programs = {
    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "agnoster";
      };

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      promptInit = ''
        fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

        #pokemon colorscripts like. Make sure to install krabby package
        #krabby random --no-mega --no-gmax --no-regional --no-title -s; 

        # Set-up icons for files/folders in terminal using lsd
        alias ls='lsd'
        alias l='ls -l'
        alias la='ls -a'
        alias lla='ls -la'
        alias lt='ls --tree'

        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
        export PKG_CONFIG_PATH=/run/current-system/sw/lib/pkgconfig
        export NODE_EXTRA_CA_CERTS=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
        if [ -d "/run/opengl-driver/lib" ]; then
          export NVIDIA_DRIVERS="/run/opengl-driver/lib"
        else
          echo "WARNING: /run/opengl-driver/lib not found! The project is unlikely to run on NixOS"
        fi
        export CUDA_HOME="${pkgs.cudaPackages.cudatoolkit}"
        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$NVIDIA_DRIVERS:${pkgs.cudatoolkit}"
        export EXTRA_LDFLAGS="-L/lib -L$NVIDIA_DRIVERS"
        # export OPENSSL_DIR=${pkgs.openssl.dev}
      '';
    };
  };
}
