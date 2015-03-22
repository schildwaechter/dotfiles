# CaT's dotfiles and more

## dotfiles

This folder contains all of CaT's public dotfiles.
They can be installed using puppet.

It has only been tested on trusty!

### install

Assuming you have puppet installed, execute the `install.sh`.

### upgrades

After pulling the latest changes or whenever you feal like it, run
```
dotfiles upgrade
```
to apply the latest version.

## more

The puppet configuration also contains software installation instructions.
You might want to run
```
dotfiles software
```
to install the provided selection (requires `sudo`).


