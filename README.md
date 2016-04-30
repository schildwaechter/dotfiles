# CaT's dotfiles and more

## dotfiles

This folder contains all of CaT's public dotfiles.
They can be installed using puppet.

This has been tested on both Ubuntu (14.04, 15.10, 16.04) and OSX 10.10.

### install

Assuming you have puppet installed, execute the `install.sh`.

### upgrades

After pulling the latest changes or whenever you feel like it, run
```
dotfiles upgrade
```
to apply the latest version.

## software

The puppet configuration also contains software installation instructions for Ubuntu.
You might want to run
```
dotfiles software
```
to install the provided selection (requires `sudo`).

It has been tested on trusty, wily and xenial – but that is no guarantee!

