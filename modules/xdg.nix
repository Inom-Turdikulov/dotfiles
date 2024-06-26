# xdg.nix
#
# Set up and enforce XDG compliance. Other modules will take care of their own,
# but this takes care of the general cases.

{ config, home-manager, pkgs, ... }:
{
  ### A tidy $HOME is a tidy mind
  home-manager.users.${config.user.name}.xdg = {
    enable = true;

    # Bind mimetypes to applications
    # you can get the mimetype with this command
    # export XDG_UTILS_DEBUG_LEVEL=2
    # xdg-mime query default application/pdf
    # xdg-mime query filetype file.ext
    mimeApps = {
      enable = true;
      defaultApplications = {
        # TODO: check raster/svg/etc enabled and only then apply associations?

        "inode/directory" = "nnn.desktop"; # directory

        # Default browser & html files
        "x-scheme-handler/http"    = "brave-browser.desktop";
        "x-scheme-handler/https"   = "brave-browser.desktop";
        "x-scheme-handler/about"   = "brave-browser.desktop";
        "x-scheme-handler/unknown" = "brave-browser.desktop";
        "text/html"                = "brave-browser.desktop"; # html5.html
        "application/xhtml+xml"    = "brave-browser.desktop"; # xhtml5.xhtml

        # Documents
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ]; # docx.docx
        "application/vnd.oasis.opendocument.text"                                 = [ "writer.desktop" ]; # odt.odt

        "application/epub+zip"           = [ "org.pwmt.zathura-cb.desktop" ]; # epub.epub
        "application/x-fictionbook+xml"  = [ "org.pwmt.zathura-cb.desktop" ]; # fictionbook.fb2
        "application/x-mobipocket-ebook" = [ "org.pwmt.zathura-cb.desktop" ]; # mobi.mobi

        "application/vnd.ms-htmlhelp"   = [ "xchm.desktop" ]; # compiledhtml.chm
        "application/x-cb7"             = [ "org.pwmt.zathura-cb.desktop" ]; # comix.cb7
        "application/vnd.comicbook-rar" = [ "org.pwmt.zathura-cb.desktop" ]; # comix.cbr
        "application/x-cbt"             = [ "org.pwmt.zathura-cb.desktop" ]; # comix.cbt
        "application/vnd.comicbook+zip" = [ "org.pwmt.zathura-cb.desktop" ]; # comix.cbz
        "application/postscript"        = [ "org.pwmt.zathura-ps.desktop" ]; # ps.ps
        "application/pdf"               = [ "org.pwmt.zathura-pdf-mupdf.desktop" ]; # pdf.pdf
        "image/vnd.djvu+multipage"      = [ "org.pwmt.zathura-djvu.desktop" ]; # djvu.djvu

        # Text Files Associated with nvim (and some other types)
        "text/x-adasrc"                = ["nvim.desktop"]; # ada.adb
        "application/x-shellscript"    = [ "nvim.desktop" ]; # shell.sh
        "application/toml"             = [ "nvim.desktop" ]; # toml.toml
        "application/xml"              = [ "nvim.desktop" ]; # xml-1.1.xml
        "application/x-yaml"           = [ "nvim.desktop" ]; # yaml.yml
        "application/x-ruby"           = [ "nvim.desktop" ]; # ruby.rb
        "application/x-awk"            = [ "nvim.desktop" ]; # awk.awk
        "application/x-perl"           = [ "nvim.desktop" ]; # perl.pl
        "application/x-php"            = [ "nvim.desktop" ]; # php.php
        "application/vnd.coffeescript" = [ "nvim.desktop" ]; # coffeescript.coffee
        "application/json"             = [ "nvim.desktop" ]; # json.json
        "application/javascript"       = [ "nvim.desktop" ]; # javascript.js
        "text/plain"                   = [ "nvim.desktop" ]; # batch.bat
        "text/x-csrc"                  = [ "nvim.desktop" ]; # c.c
        "text/x-chdr"                  = [ "nvim.desktop" ]; # c.h
        "text/x-cobol"                 = [ "nvim.desktop" ]; # cobol.cob
        "text/x-c++src"                = [ "nvim.desktop" ]; # cpp.cpp
        "text/x-crystal"               = [ "nvim.desktop" ]; # crystal.cr
        "text/x-csharp"                = [ "nvim.desktop" ]; # csharp.cs
        "text/css"                     = [ "nvim.desktop" ]; # css.css
        "text/x-eiffel"                = [ "nvim.desktop" ]; # eiffel.e
        "text/x-elixir"                = [ "nvim.desktop" ]; # elixir.ex
        "text/x-fortran"               = [ "nvim.desktop" ]; # fortran-90.f90
        "text/x-go"                    = [ "nvim.desktop" ]; # go.go
        "text/x-groovy"                = [ "nvim.desktop" ]; # groovy.groovy
        "text/x-haskell"               = [ "nvim.desktop" ]; # haskell_loop.hs
        "text/x-java"                  = [ "nvim.desktop" ]; # java.java
        "text/x-lua"                   = [ "nvim.desktop" ]; # lua.lua
        "text/x-makefile"              = [ "nvim.desktop" ]; # Makefile
        "text/markdown"                = [ "nvim.desktop" ]; # markdown.md
        "text/x-objcsrc"               = [ "nvim.desktop" ]; # objective-c.m
        "text/x-ocaml"                 = [ "nvim.desktop" ]; # ocaml.ml
        "text/x-pascal"                = [ "nvim.desktop" ]; # pascal.pas
        "text/x-python"                = [ "nvim.desktop" ]; # python.py
        "text/rust"                    = [ "nvim.desktop" ]; # rust.rs
        "text/x-scala"                 = [ "nvim.desktop" ]; # scala.scala
        "text/vnd.trolltech.linguist"  = [ "nvim.desktop" ]; # typescript.ts

        # Raster Images
        "image/x-eps"              = [ "org.pwmt.zathura-cb.desktop" ]; # eps.eps
        "image/jp2"                = [ "org.darktable.darktable.desktop" ]; # jpeg2.jp2, nsxiv can't open it
        "image/webp"               = [ "com.interversehq.qView.desktop" ]; # webp.webp
        "image/jpeg"               = [ "com.interversehq.qView.desktop" ]; # jpeg.jpg
        "image/png"                = [ "com.interversehq.qView.desktop" ]; # png-transparent.png
        "image/tiff"               = [ "com.interversehq.qView.desktop" ]; # tiff.tif
        "image/gif"                = [ "com.interversehq.qView.desktop" ]; # gif-transparent.gif
        "image/bmp"                = [ "com.interversehq.qView.desktop" ]; # bmp.bmp
        "image/vnd.microsoft.icon" = [ "com.interversehq.qView.desktop" ]; # ico.ico
        "image/heif"               = [ "com.interversehq.qView.desktop" ]; # heif.heif
        "image/x-portable-bitmap"  = [ "com.interversehq.qView.desktop" ]; # pbm.pbm
        "image/x-portable-graymap" = [ "com.interversehq.qView.desktop" ]; # pgmb.pgm
        "image/x-tga"              = [ "com.interversehq.qView.desktop" ]; # targa.tga
        "image/jxl"                = [ "com.interversehq.qView.desktop" ]; # jxl.jxl
        "image/x-xbitmap"          = [ "com.interversehq.qView.desktop" ]; # x-bitmap.xbm
        "image/x-portable-pixmap"  = [ "com.interversehq.qView.desktop" ]; # ppmb.ppm

        # Vector Images
        "image/wmf"     = [ "org.inkscape.Inkscape.desktop" ]; # WindowsMetafile.wmf
        "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ]; # svg.svg

        # Multimedia
        "application/x-cue"                 = [ "mpv.desktop" ]; # cue.cue
        "application/vnd.adobe.flash.movie" = [ "mpv.desktop" ]; # flash.swf
        "video/mpeg"                        = [ "mpv.desktop" ]; # video.mpg
        "video/x-matroska"                  = [ "mpv.desktop" ]; # video.mkv
        "video/x-msvideo"                   = [ "mpv.desktop" ]; # AudioVideoInterleave.avi
        "video/x-flv"                       = [ "mpv.desktop" ]; # FlashVideo.flv
        "video/mp4"                         = [ "mpv.desktop" ]; # mp4-with-audio.mp4
        "audio/x-m4b"                       = [ "mpv.desktop" ]; # m4b.m4b
        "video/x-ms-wmv"                    = [ "mpv.desktop" ]; # WindowsMediaVideo.wmv
        "video/webm"                        = [ "mpv.desktop" ]; # webm.webm
        "audio/flac"                        = [ "mpv.desktop" ]; # flac.flac
        "audio/vnd.wav"                     = [ "mpv.desktop" ]; # wav.wav
        "audio/x-wav"                       = [ "mpv.desktop" ]; # wav.wav
        "audio/mpeg"                        = [ "mpv.desktop" ]; # mp3.mp3

        # Archives and octet-stream
        "application/octet-stream"    = [ "xarchiver.desktop" ]; # unknow files, TODO: better use here universal viewer tool?
        "application/gzip"            = [ "xarchiver.desktop" ]; # gzip.gz
        "application/x-bzip"          = [ "xarchiver.desktop" ]; # bzip2.bz2
        "application/zstd"            = [ "xarchiver.desktop" ]; # zstd.zstd
        "application/vnd.rar"         = [ "xarchiver.desktop" ]; # rar5.rar
        "application/x-7z-compressed" = [ "xarchiver.desktop" ]; # 7zip.7z
        "application/zip"             = [ "xarchiver.desktop" ]; # zip.zip
        "application/x-tar"           = [ "xarchiver.desktop" ]; # tar.tar
      };
    };
  };

  environment = {
    sessionVariables = {
      # These are the defaults, and xdg.enable does set them, but due to load
      # order, they're not set before environment.variables are set, which could
      # cause race conditions.
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_BIN_HOME    = "$HOME/.local/bin";
    };
    variables = {
      # Conform more programs to XDG conventions. The rest are handled by their
      # respective modules.
      __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      ASPELL_CONF = ''
        per-conf $XDG_CONFIG_HOME/aspell/aspell.conf;
        personal $XDG_CONFIG_HOME/aspell/en_US.pws;
        repl $XDG_CONFIG_HOME/aspell/en.prepl;
      '';
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      HISTFILE        = "$XDG_DATA_HOME/bash/history";
      INPUTRC         = "$XDG_CONFIG_HOME/readline/inputrc";
      LESSHISTFILE    = "$XDG_CACHE_HOME/lesshst";
      WGETRC          = "$XDG_CONFIG_HOME/wgetrc";

      # Tools I don't use
      # SUBVERSION_HOME = "$XDG_CONFIG_HOME/subversion";
      # BZRPATH         = "$XDG_CONFIG_HOME/bazaar";
      # BZR_PLUGIN_PATH = "$XDG_DATA_HOME/bazaar";
      # BZR_HOME        = "$XDG_CACHE_HOME/bazaar";
      # ICEAUTHORITY    = "$XDG_CACHE_HOME/ICEauthority";
    };

    # Move ~/.Xauthority out of $HOME (setting XAUTHORITY early isn't enough)
    extraInit = ''
      export XAUTHORITY=/tmp/Xauthority
      [ -e ~/.Xauthority ] && mv -f ~/.Xauthority "$XAUTHORITY"
    '';
  };
}