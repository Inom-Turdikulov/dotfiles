{ pkgs, config, lib, ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      dwm.enable = true;
      apps = {
        rofi.enable = true;
        godot.enable = true;
        slack.enable = true;
      };
      browsers = {
        default = "brave";
        brave.enable = true;
        firefox.enable = true;
        qutebrowser.enable = true;
      };
      gaming = {
        steam.enable = true;
        # emulators.enable = true;
        # emulators.psx.enable = true;
      };
      media = {
        daw.enable = true;
        documents.enable = true;
        documents.office.enable = true;
        graphics.enable = true;
        mpv.enable = true;
        recording.enable = true;
        spotify.enable = true;
      };
      term = {
        default = "xst";
        st.enable = true;
      };
      vm = {
        qemu.enable = true;
      };
    };
    dev = {
      node.enable = true;
      rust.enable = true;
      python.enable = true;
      cc.enable = true;
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
      vim.enable = true;
    };
    shell = {
      wget.enable   = true;
      adl.enable    = true;
      direnv.enable = true;
      git.enable    = true;
      gnupg.enable  = true;
      tmux.enable   = true;
      zsh.enable    = true;
      sc-im.enable  = true;
      du-dust.enable  = true;
      db.enable     = true;
      xh.enable     = true;
      pass.enable   = true;
      w3m.enable    = true;
      tealdeer.enable  = true;
<<<<<<< HEAD
      vaultwarden.enable = false;
=======
      ttyper.enable = true;
>>>>>>> 5d3e653 (Add ttyper shell keybord tutor)
    };
    services = {
      dictd.enable = true;
      ssh.enable = true;
      docker.enable = true;
      syncthing.enable = true;

      # Needed occasionally to help the parental units with PC problems
      # teamviewer.enable = true;
    };
    theme.active = "alucard";
  };


  ## Local config
  programs.ssh.startAgent = false;

  services.openssh.startWhenNeeded = true;
  services.pcscd.enable = true; # for gpg-agent

  networking.networkmanager.enable = true;
}
