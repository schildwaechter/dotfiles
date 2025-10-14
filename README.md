# CaT's dotfiles and more

## dotfiles

This folder contains all of CaT's public dotfiles.
They can be installed using puppet.

This has most recently been tested on both Debian 12 and macOS 15.

### install

The repository uses submodules

```shell
git clone https://github.com/schildwaechter/dotfiles ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update
```

Install [OpenVox](https://voxpupuli.org/openvox/install) as we use puppet configs.

Then run `install.sh` from within the folder.

### upgrades

After pulling the latest changes or whenever you feel like it, run

```shell
dotfiles upgrade
```

to apply the latest version.

## software

### dependencies

Some software must (currently) be installed manually

* [Oh My Posh](https://ohmyposh.dev/)
  and the [Nerd Font](https://ohmyposh.dev/docs/installation/fonts)

### macOS

See [macOS.md](macOS.md).

### Ubuntu software packages

The puppet configuration also contains software installation for Debian, via

```shell
dotfiles software
```

to install the provided selection (requires `sudo`).

It has most recently been tested on bookworm.
