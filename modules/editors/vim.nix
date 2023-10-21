# When I'm stuck in the terminal or don't have access to Emacs, (neo)vim is my
# go-to. I am a vimmer at heart, after all.

{ config, lib, pkgs, home, inputs, buildNpmPackage
, fetchFromGitHub
, fetchpatch, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.vim;
    configDir = config.dotfiles.configDir;

    # Looad plugin from github
    # usage (fromGitHub "HEAD" "user/repo")
    fromGitHub = rev: repo: pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = rev;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        rev = rev;
      };
    };
in {
  options.modules.editors.vim = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    # dasht docsets path
    env.DASHT_DOCSETS_DIR = "${config.user.home}/Reference/docsets";

    user.packages = with pkgs; [
      vimgolf             # A game that tests Vim efficiency, train vim skills
      dasht               # to search in docsets

      git
      gnutls              # for TLS connectivity
      fd                  # faster projectile indexing

      # required for telescope-media-files-nvim
      chafa
      poppler_utils
      imagemagick

      ## Module dependencies
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      editorconfig-core-c
      sqlite
      texlive.combined.scheme-medium

      ## LSP
      lua-language-server
      clang-tools  # NOTE: sync this with cc.nix
      ltex-ls
      nil             # Yet another language server for Nix
      efm-langserver  # for formatting
      unstable.emmet-ls

      ## Formatting
      luaformatter

      ## Debugging
      vscode-extensions.vadimcn.vscode-lldb
      my.vscode-js-debug

      # Desktop file
      (makeDesktopItem {
        name = "nvim";
        desktopName = "Neovim Text Editor";
        comment = "Edit text files";
        tryExec = "nvim";
        exec = "${pkgs.xst}/bin/xst -e nvim %F";
        terminal = false;
        type = "Application";
        keywords = [ "Text" "editor" ];
        icon = "nvim";
        categories = [ "Utility" "TextEditor" ];
        startupNotify = false;
        mimeTypes = [ "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++" ];
      })
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      configure = {
         customRC = ''
           luafile $XDG_CONFIG_HOME/nvim/init.lua
         '';

         packages.neovimPlugins = with pkgs.vimPlugins; {
             start = [
                 plenary-nvim

                 onedark-nvim
                 nvim-web-devicons
                 (fromGitHub "30f04edb9647d9ea7c08d0bdbfad33faf5bcda57" "tjdevries/express_line.nvim")
                 (fromGitHub "2c17843b074b06a835f88587e1023ceff7e2c7d1" "Glench/Vim-Jinja2-Syntax")

                 telescope-nvim
                 telescope-file-browser-nvim
                 (fromGitHub "bd5d323581f24ee124b33688287e6a22244c6f2a" "renerocksai/telekasten.nvim")

                 (fromGitHub "ea7e07e935f3f95deda97f9f6dc87f7bcf3fb69a" "phelipetls/jsonpath.nvim")
                 vim-fugitive
                 vim-rsi
                 vim-gnupg

                 refactoring-nvim
                 vim-dasht
                 nvim-treesitter.withAllGrammars
                 harpoon
                 which-key-nvim
                 comment-nvim
                 undotree
                 nvim-ufo
                 nvim-surround
                 trouble-nvim


                 popup-nvim
                 telescope-media-files-nvim  # required plenary-nvim, popup.nvim, telescope.nvim

                 sniprun
                 (fromGitHub "083782f05e67cc08c6378affec9f55a913ac55f4" "antonk52/markdowny.nvim")
                 (fromGitHub "a108a87639a43f5386dd70bdf512de3806a71f7d" "cbochs/portal.nvim")

                 copilot-lua
                 copilot-cmp

                 nvim-dap
                 nvim-dap-ui
                 nvim-dap-virtual-text
                 nvim-dap-python
                 telescope-dap-nvim
                 (fromGitHub "03bd29672d7fab5e515fc8469b7d07cc5994bbf6" "mxsdev/nvim-dap-vscode-js")

                 neotest
                 neotest-rust
                 neotest-python

                 # LSP, autocomplete and snippets
                 nvim-lspconfig
                 nvim-cmp
                 cmp-buffer
                 cmp-path
                 cmp-nvim-lsp
                 luasnip
                 cmp_luasnip
                 friendly-snippets
                 ltex_extra-nvim
                 (fromGitHub "082c4040c3d56c9ef56e1e7142000438eb542caf" "creativenull/efmls-configs-nvim")
             ];
         };
       };
    };

    environment.shellAliases = {
      vim = "nvim";
      v   = "nvim";
    };

    # fonts.packages = [ pkgs.vim-all-the-icons-fonts ];
  };
}