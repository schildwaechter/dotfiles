# MacOS specifics

## Config

Run the `macos.sh` script for a number of settings.

To install the keyboard layout, do
```bash
sudo cp ~/.dotfiles/us_cat/osx/*.keylayout /Library/Keyboard\ Layouts
```
then copy the Caps-Lock-Fix
```bash
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

### Homebrew

```shell
brew tap 1password/tap
brew install --cask 1password/tap/1password-cli
brew tap puppetlabs/puppet
brew install --cask puppetlabs/puppet/puppet-agent
brew install --cask meld
brew install bash
brew install ansible
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
brew install exa
brew install fzf
brew install jq
brew install yq
brew install grip
brew install tree
brew install direnv
brew install btop
brew install gdu
brew install tmux
brew install neofetch
brew install httpie
brew install watch
brew install tfk8s
brew install podman-desktop
brew install minikube
brew install istioctl
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

```
