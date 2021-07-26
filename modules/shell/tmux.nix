{ config, options, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.tmux;
    configDir = config.dotfiles.configDir;
in {
  options.modules.shell.tmux = with types; {
    enable = mkBoolOpt false;
    rcFiles = mkOpt (listOf (either str path)) [];
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [ tmux ];

    modules.theme.onReload.tmux = "${pkgs.tmux}/bin/tmux source-file $TMUX_HOME/extraInit";

    modules.shell.zsh = {
      rcInit = "_cache tmuxifier init -";
      rcFiles = [ "${configDir}/tmux/aliases.zsh" ];
    };

    home.configFile = {
      "tmux" = { source = "${configDir}/tmux"; recursive = true; };
      "tmux/extraInit".text = ''
        # This file is auto-generated by nixos, don't edit by hand!
        run-shell ${pkgs.tmuxPlugins.copycat}/share/tmux-plugins/copycat/copycat.tmux
        run-shell ${pkgs.tmuxPlugins.prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
        run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux

        ${concatMapStrings (path: "source '${path}'\n") cfg.rcFiles}
      '';
    };

    env = {
      PATH = [ "$TMUXIFIER/bin" ];
      TMUX_HOME = "$XDG_CONFIG_HOME/tmux";
      TMUXIFIER = "$XDG_DATA_HOME/tmuxifier";
      TMUXIFIER_LAYOUT_PATH = "$XDG_DATA_HOME/tmuxifier";
    };
  };
}
