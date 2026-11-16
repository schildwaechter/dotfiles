# MacOS specifics

## Config

Run the `macos.sh` script for a number of settings.

To install the keyboard layout, do

```shell
sudo cp ~/.dotfiles/us_cat/macOS/*.keylayout /Library/Keyboard\ Layouts
```

then copy the Caps-Lock-Fix

```shell
cp ~/.dotfiles/macos-KeyRemapping.plist ~/Library/LaunchAgents/com.local.KeyRemapping.plist
```

log out and back in and apply through settings.

## MacOS software

Mac software installation is not automated.

* [1Password](https://1password.com/downloads/mac/)
* [Nextcloud](https://nextcloud.com/install/)
* [Firefox](https://www.mozilla.org/en-US/firefox/new/)
* [MacVim](https://macvim.org/)
* [Homebrew](https://brew.sh/)
* [Rectangle](https://rectangleapp.com/)

```shell
sudo nvram StartupMute=%01
```

### Homebrew

Use the Brewfile

```shell
brew bundle install --file=~/.dotfiles/Brewfile
```

and fix permissions

```shell
xattr -rd com.apple.quarantine /Applications/MacMediaKeyForwarder.app
```

```shell
oh-my-posh font install meslo
```

```shell
kubectl krew list
PLUGIN         VERSION
klock          v0.9.1
modify-secret  v0.0.47
neat           v2.0.4
tree           v0.4.3
who-can        v0.4.0
```

```shell
helm plugin install https://github.com/databus23/helm-diff
```

Local `.zshrc`

```shell
bindkey "\e[3~" delete-char
bindkey "^[^[[C" forward-word ## mac with option/alt
bindkey "^[^[[D" backward-word ## mac with option/alt
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(oh-my-posh init zsh --config ~/.dotfiles/oh-my-posh.yaml)"
```
