{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.weechat;
in {
  options.modules.shell.weechat = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      (weechat.override {
         configure = { availablePlugins, ... }: {
           scripts = with pkgs.weechatScripts; [
             weechat-notify-send
             weechat-go
             weechat-autosort
           ];
         };
      })
    ];
  };
}