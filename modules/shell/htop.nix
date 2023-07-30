{ config, options, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.htop;
    configDir = config.dotfiles.configDir;
in {
  options.modules.shell.htop = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      htop

      # Otpional packages
      lm_sensors  # show CPU temperature
      lsof        # show open files
      strace      # attach to running process
    ];
  };
}
