# MacOS specifics

## Config

Run the `macos.sh` script for a number of settings.

To install the keyboard layout, do

```shell
sudo cp ~/.dotfiles/us_cat/osx/*.keylayout /Library/Keyboard\ Layouts
```

then copy the Caps-Lock-Fix

```shell
cp ~/.dotfiles/macos-KeyRemapping.plist ~/Library/LaunchAgents/com.local.KeyRemapping.plist
```

log out and back in and apply through settings.

## MacOS software

Mac software installation is not automated.

* [iTerm2](https://iterm2.com/)
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

```shell
brew install --cask ghostty
brew tap 1password/tap
brew install --cask 1password/tap/1password-cli
brew tap puppetlabs/puppet
brew install --cask puppetlabs/puppet/puppet-agent
brew install --cask meld
brew install bash
brew install btop
brew install coreutils
brew install gh
brew install kubernetes-cli
brew install kubectx
brew install kubeseal
brew install helm
brew install k9s
brew install kustomize
brew install pre-commit
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew install terraform-docs
brew install pre-commit
brew install fluxcd/tap/flux && brew link flux
brew install google-cloud-sdk
brew install azure-cli
brew install Azure/kubelogin/kubelogin
brew install cue
brew install go
brew install dust
brew install bat
brew install fastfetch
brew install bottom
brew install fzf
brew install jq
brew install yq
brew install grip
brew install ripgrep
brew install tree
brew install direnv
brew install btop
brew install gdu
brew install tmux
brew install httpie
brew install bruno
brew install watch
brew install tfk8s
brew install podman-desktop
brew install minikube
brew install istioctl
brew install tilt
brew install ctlptl
brew tap robusta-dev/homebrew-krr
brew install FairwindsOps/tap/pluto
brew install krr
brew install --cask virtualbox
brew install --cask notunes
brew install --cask spotify
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask firefox
brew install --cask paintbrush
brew install --cask font-meslo-lg-nerd-font
brew install jandedobbeleer/oh-my-posh/oh-my-posh
```

```shell
oh-my-posh font install meslo
```

```shell
kubectl krew list
PLUGIN         VERSION
modify-secret  v0.0.47
neat           v2.0.4
tree           v0.4.3
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
