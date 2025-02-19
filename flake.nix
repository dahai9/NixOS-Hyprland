# 💫 https://github.com/JaKooLit 💫 #
{
  description = "KooL's NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nvf,
    ...
  }: let
    system = "x86_64-linux";
    host = "Legion";
    username = "dahai003";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        alalowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
          inherit host;
        };
        modules = [
          ./hosts/${host}/config.nix
          ./overlay
          nvf.nixosModules.default
          inputs.distro-grub-themes.nixosModules.${system}.default
        ];
      };
    };
    packages."x86_64-linux"."PingFang" = import ./pkgs/fonts/PingFang {inherit (nixpkgs.legacyPackages."x86_64-linux") stdenvNoCC unzip fetchurl;};
    packages."aarch64-darwin"."PingFang" = import ./pkgs/fonts/PingFang {inherit (nixpkgs.legacyPackages."aarch64-darwin") stdenvNoCC unzip fetchurl;};

    packages."x86_64-linux"."SF-Pro" = import ./pkgs/fonts/SF-Pro {inherit (nixpkgs.legacyPackages."x86_64-linux") stdenvNoCC unzip fetchurl;};
    packages."aarch64-darwin"."SF-Pro" = import ./pkgs/fonts/SF-Pro {inherit (nixpkgs.legacyPackages."aarch64-darwin") stdenvNoCC unzip fetchurl;};
  };
}
