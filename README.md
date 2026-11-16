# CaT's dotfiles and more

## dotfiles

This repository contains public dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

This has most recently been tested on CachyOS and macOS 27.

### Install

Install chezmoi using the [official instructions](https://www.chezmoi.io/install/), then clone this repository. The repository uses submodules:

```shell
git clone https://github.com/schildwaechter/dotfiles ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update
```

Sync `~/.dotsecrets` before applying the configuration. It remains outside this repository and holds host-specific SSH configuration and Git signing metadata.

Set non-secret machine identity in the untracked chezmoi configuration:

```toml
# ~/.config/chezmoi/chezmoi.toml
[data]
gitName = "Your Name"
gitEmail = "you@example.com"
gitSigningKey = "ssh-ed25519 AAAA..."
```

Then run the bootstrap from the repository root:

```shell
./install.sh
```

It configures `chezmoi` to use `~/.dotfiles/chezmoi` and shows the pending changes. Review them, then apply:

```shell
chezmoi apply
```

### Updates

After pulling the latest changes and updating submodules, run:

```shell
chezmoi apply
```

Use `chezmoi diff` before applying when you want to inspect the rendered changes.

### Secrets

The public chezmoi source renders configuration that refers to the externally synced `~/.dotsecrets` directory. In particular:

* `~/.ssh/config` includes `~/.dotsecrets/ssh/config_<hostname>`.
* `~/.gitconfig` reads `~/.dotsecrets/ssh/allowed_git_signers`.
* Legacy paths for fonts, TeX, Pidgin logs, and the face image are symlinked to their existing `.dotsecrets` locations.

Do not add `.dotsecrets` to this repository. A missing host-specific SSH include is reported by SSH only when it is used, but Nextcloud should finish syncing before the first apply.

## Software

Some software must (currently) be installed manually

* [Oh My Posh](https://ohmyposh.dev/)
  and the [Nerd Font](https://ohmyposh.dev/docs/installation/fonts)

### Linux

See [Linux.md](Linux.md).

### macOS

See [macOS.md](macOS.md).
