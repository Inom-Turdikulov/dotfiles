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
    user.packages = with pkgs; [
        (pkgs.writeScriptBin "chatgpt-cli" ''
        #!/bin/sh
        KEYS=~/.profile-keys && test -f $KEYS && source $KEYS
        unset KEYS
        xst -c chatgpt -e chatgpt
        '')
        (pkgs.writeScriptBin "wiki" ''
        #!/bin/sh
        cd ~/Wiki && xst -c wiki -e nvim Now.md
        '')
        (pkgs.writeScriptBin "trans-ru" ''
        #!/bin/sh
        xst -c trans -e trans -shell ru:en
        '')
        (pkgs.writeScriptBin "newsboat-cli" ''
        #!/bin/sh
        xst -c newsboat -e newsboat
        '')
        (pkgs.writeScriptBin "weechat-cli" ''
        #!/bin/sh
        xst -c weechat -e weechat
        '')
    ];
    home.dataFile."dwm/autostart.sh" = {
        text = ''
#!/bin/sh

# Load theme specific settings
[[ ! -f $XDG_CONFIG_HOME/xtheme.init ]] || $XDG_CONFIG_HOME/xtheme.init

# Bind F13 (XF86Tools) to mod3mask key
xmodmap -e "clear mod3" -e "add mod3 = XF86Tools"

# Set cursor shape
xsetroot -cursor_name left_ptr

# Load some IRL-sensentive apps and bloatware ;-)
thunderbird &
slack &
telegram-desktop &
spotify &
'';
        executable = true;
    };

    environment.systemPackages = with pkgs; [
      dunst
      libnotify
      dmenu
      alsa-utils   # for dwm-status
      xorg.xmodmap # to set mod3 key
      jumpapp      # quick switch between apps
    ];

    # My custom dmenu scripts
    env.PATH = [ "$DOTFILES_BIN/dmenu" ];

    services = {
      picom.enable = true;
      redshift.enable = true;
      xserver = {
        enable = true;

        # Configure keymap in X11
        layout = "us,ru";
        xkbVariant = "colemak_dh,";
        xkbOptions = "grp:menu_toggle,lv5:ralt_switch";

        displayManager = {
          defaultSession = "none+dwm";
          lightdm.enable = true;
          lightdm.greeters.mini.enable = true;
        };
        windowManager.dwm = {
          enable = true;
          package = pkgs.dwm.overrideAttrs (old: {
           src = pkgs.fetchFromGitHub {
             owner = "Inom-Turdikulov";
             repo = "dwm-flexipatch";
             rev = "2db78f3982f5fc8da4898f6159069e6eeb95dafd";
             hash = "sha256-PNNcc354kRQWXKhwemgr3bPl/8Ea9GrJ35YSulKnWGY=";
           };
        });
        };
      };
      dwm-status = {
        enable = true;
        order = ["time"];
	extraConfig = ''
separator = " / "

[time]
format = "%A, %d.%m [%B], %H:%M"
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