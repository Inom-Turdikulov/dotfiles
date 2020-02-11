# Mein dotfiles

A tidy `$HOME` is a tidy mind.

![Me looking busy](/../screenshots/fluorescence/fakebusy.png?raw=true)

<p align="center">
<span><img src="/../screenshots/fluorescence/desktop.png?raw=true" height="188" /></span>
<span><img src="/../screenshots/fluorescence/rofi.png?raw=true" height="188" /></span>
<span><img src="/../screenshots/fluorescence/tiling.png?raw=true" height="188" /></span>
</p>

It takes a touch of madness to use nixOS. I arrived here because there are a few
special computers in my life, local and remote, and maintaining them was
busywork I wouldn't wish on my worst enemy. 

Nix, with its luscious tendrils, drew me in with a promise of glorious
reproducibility and declared its declarative-ness with enough chutzpah to make
anime real again. So, with XDG conventions in hand, I set out to conquer my
white whale and annihilate what vestiges of my social life remain.

## Quick start

```sh
# Assumes your partitions are set up and root is mounted on /mnt
curl https://raw.githubusercontent.com/hlissner/dotfiles/nixos/deploy | sh
```

This is equivalent to:

```sh
DOTFILES=/home/$USER/.dotfiles
git clone https://github.com/hlissner/dotfiles $DOTFILES
ln -s /etc/dotfiles $DOTFILES
chown -R $USER:users $DOTFILES

# make channels
nix-channel --add "https://nixos.org/channels/nixos-${NIXOS_VERSION}" nixos
nix-channel --add "https://github.com/rycee/home-manager/archive/release-${NIXOS_VERSION}.tar.gz" home-manager
nix-channel --add "https://nixos.org/channels/nixpkgs-unstable" nixpkgs-unstable

# make /etc/nixos/configuration.nix
nixos-generate-config --root /mnt
echo "import /etc/dotfiles \"$$(hostname)\"" >/mnt/etc/nixos/configuration.nix

# make secrets.nix
nix-shell -p gnupg --run "gpg -dq secrets.nix.gpg >secrets.nix"

# make install
nixos-install --root /mnt -I "my=/etc/dotfiles"
```

### Management

+ `make` = `nixos-rebuild test`
+ `make switch` = `nixos-rebuild switch`
+ `make upgrade` = `nix-channel --update && nixos-rebuild switch`
+ `make install` = `nixos-generate-config --root $PREFIX && nixos-install --root
  $PREFIX`
+ `make gc` = `nix-collect-garbage -d` (use sudo to clear system profile)

## Overview

+ OS: NixOS 19.09
+ Shell: zsh
+ DE/WM: bspwm + polybar
+ Editor: [Doom Emacs][doom-emacs] (and occasionally [vim][vimrc])
+ Terminal: st
+ Browser: firefox (waiting for qutebrowser to mature)


[doom-emacs]: https://github.com/hlissner/doom-emacs
[vimrc]: https://github.com/hlissner/.vim
