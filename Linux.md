# Linux specifics

All Linux system setup is handled by the unified `linux.sh` script,
which detects the distribution and runs the appropriate steps.

## Config

Run the full setup:

```shell
sudo ./linux.sh --all
```

Run `sudo ./linux.sh --help` for the full option list:

```shell
sudo ./linux.sh --packages                         # install distro-specific packages and sources
sudo ./linux.sh --locale                           # generate locales
sudo ./linux.sh --keyboard                         # install custom XKB layouts
sudo ./linux.sh --keyboard --set-default-keyboard  # …and make us_cat the default
sudo ./linux.sh --sysctl                           # apply sysctl settings
sudo ./linux.sh --sudoers                          # enable sudo insults
sudo ./linux.sh --shell                            # set zsh as default shell
sudo ./linux.sh --lima                             # install/update Lima VM
```

## Keyboard layout

To install CaT's custom `us_cat` layout and make it available in the desktop environment's keyboard selector:

```shell
sudo ./linux.sh --keyboard
```

To also set it as the system default layout:

```shell
sudo ./linux.sh --keyboard --set-default-keyboard
```

## Distribution notes

### Debian / Ubuntu

`linux.sh --packages` configures apt sources (VirtualBox, VS Code) and installs the package selection.
It has most recently been tested on Debian 12 (bookworm).

### Arch / CachyOS

`linux.sh --packages` installs the package selection via `pacman`.
Niri is assumed to come from the base CachyOS install and is not installed here.

Services enabled:

- `docker.service`
- user `gcr-ssh-agent.socket`
- user `ssh-agent.service`

The calling user is added to the `docker` group.

## Lima VM

`linux.sh --lima` installs Lima from the official GitHub releases into `/usr/local`.

```shell
sudo ./linux.sh --lima
```

To force a reinstall or upgrade:

```shell
sudo ./linux.sh --lima --force
```

## dotfiles command

After running the dotfiles install, the `dotfiles` shell function provides:

```shell
dotfiles upgrade   # apply dotfiles via puppet (user-space side)
dotfiles update    # update the dotfiles repository
dotfiles status    # check the dotfiles repository status
dotfiles software  # run linux.sh --packages
```

