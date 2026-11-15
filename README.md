# CaT's dotfiles and more

## dotfiles

This folder contains all of CaT's public dotfiles.

This has most recently been tested on CachyOS and macOS 27.

### Install

The repository uses submodules

```shell
git clone https://github.com/schildwaechter/dotfiles ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update
```

Then run `install.sh` from within the folder, assuming you have OpenVox (below).

### upgrades

After pulling the latest changes or whenever you feel like it, run

```shell
dotfiles upgrade
```

to apply the latest version.

## Software

Some software must (currently) be installed manually

* [Oh My Posh](https://ohmyposh.dev/)
  and the [Nerd Font](https://ohmyposh.dev/docs/installation/fonts)
* [OpenVox](https://voxpupuli.org/openvox/install)

### Linux

See [Linux.md](Linux.md).

### macOS

See [macOS.md](macOS.md).
