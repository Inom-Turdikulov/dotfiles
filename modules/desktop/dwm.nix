{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.dwm;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.dwm = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.dataFile."dwm/autostart.sh" = {
        text = ''
#!/bin/sh

# Load theme specific settings
[[ ! -f $XDG_CONFIG_HOME/xtheme.init ]] || $XDG_CONFIG_HOME/xtheme.init'';
        executable = true;
    };

    nixpkgs.overlays = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (old: {
           src = pkgs.fetchFromGitHub {
             owner = "Inom-Turdikulov";
             repo = "dwm-flexipatch";
             rev = "7975df5b1854087f261e48fdcf71ce7f847c2ba8";
             hash = "sha256-dgoaCfajzdD3rlTeU73OIJ9QK4lXdS8S8/SvsDSyoLc=";
           };
        });
      })
    ];

    environment.systemPackages = with pkgs; [
      lightdm
      dunst
      libnotify
      dmenu
      alsa-utils  # for dwm-status
    ];

    # My custom dmenu scripts
    env.PATH = [ "$DOTFILES_BIN/dmenu" ];

    services = {
      picom.enable = false;
      redshift.enable = true;
      xserver = {
        enable = true;

        # Configure keymap in X11
        layout = "us,ru";
        xkbVariant = "colemak_dh,";
        xkbOptions = "grp:menu_toggle";

        displayManager = {
          defaultSession = "none+dwm";
          lightdm.enable = true;
          lightdm.greeters.mini.enable = true;
        };
        windowManager.dwm = {
          enable = true;
        };
      };
      dwm-status = {
        enable = true;
        order = ["time"];
	extraConfig = ''
separator = " / "

[time]
format = "%A, %B %d %H:%M:%S"
	'';
      };
      gvfs.enable = true;
    };

    systemd.user.services."dunst" = {
      enable = true;
      description = "";
      wantedBy = [ "default.target" ];
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 2;
      serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
    };

    # link recursively so other modules can link files in their folders
    home.configFile = {
      "sxhkd".source = "${configDir}/sxhkd";
    };
  };
}
