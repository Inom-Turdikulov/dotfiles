# 1. Create three (3) disk images:
#    - Installer: 1024mb
#    - Swap: 512mb
#    - NixOS: rest
#
# 2. Boot in rescue mode with:
#    - /dev/sda -> Installer
#    - /dev/sdb -> Swap
#    - /dev/sdc -> NixOS
#
# 3. Once booted into Finnix (step 2) pipe this script to sh:
#      iso=https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso
#      update-ca-certificates
#      curl -k $iso | dd bs=1M of=/dev/sda
#
# 4. Create two configuration profiles:
#    - Installer
#      - Kernel: Direct Disk
#      - /dev/sda -> NixOS
#      - /dev/sdb -> Swap
#      - /dev/sdc -> Installer
#      - Helpers: distro and auto network helpers = off
#    - Boot
#      - Kernel: GRUB 2
#      - /dev/sda -> NixOS
#      - /dev/sdb -> Swap
#      - Helpers: distro and auto network helpers = off
#
# 5. Boot into installer profile.
#
# 6. Install dotfiles:
#      mount /dev/sda /mnt
#      swapon /dev/sdb
#      nix-env -iA nixos.git nixos.nixFlakes
#      mkdir -p /mnt/home/hlissner/.config
#      cd /mnt/home/hlissner/.config
#      git clone https://github.com/hlissner/dotfiles
#      nixos-generate-config --root /mnt
#      nixos-install --root /mnt --flake .#linode --impure
#
# 7. Reboot into "Boot" profile.

{ config, lib, pkgs, ... }:

with lib;
{
  imports = filter pathExists [
    /etc/nixos/hardware-configuration.nix
  ];

  environment.systemPackages =
    with pkgs; [ inetutils mtr sysstat git ];

  modules = {
    editors = {
      default = "nvim";
      vim.enable = true;
    };
    shell = {
      git.enable = true;
      zsh.enable = true;
    };
    services.ssh.enable = true;
  };

  # GRUB
  boot = {
    kernelParams = [ "console=ttyS0" ];
    loader = {
      timeout = 10;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        copyKernels = true;
        fsIdentifier = "label";
        extraConfig = "serial; terminal_input serial; terminal_output serial";
      };
      # Disable globals
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = false;
    };
  };

  networking = {
    useDHCP = false;
    usePredictableInterfaceNames = false;
    interfaces.eth0 = {
      useDHCP = true;
      preferTempAddress = false;
    };
  };
}
