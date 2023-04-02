# CaT's dotfiles and more

## dotfiles

This folder contains all of CaT's public dotfiles.
They can be installed using puppet.

This has most recently been tested on both Ubuntu (22.04) and macOS 13.

### install

The repository uses submodules
```
git clone https://github.com/schildwaechter/dotfiles ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update
```

Install [puppet](https://www.puppet.com/docs/puppet/7/install_agents.html) installed, execute the `install.sh`.
```bash
wget -q "https://apt.puppetlabs.com/puppet-release-$(lsb_release -cs).deb"
dpkg -i "puppet-release-$(lsb_release -cs).deb";
rm "puppet-release-$(lsb_release -cs).deb";
apt-get update;
apt-get -y install puppet-agent;
```
or
```
https://downloads.puppetlabs.com/mac/puppet7
```

Then run `install.sh` from within the folder.

### upgrades

After pulling the latest changes or whenever you feel like it, run
```
dotfiles upgrade
```
to apply the latest version.

## software

### dependencies

Some software must (currently) be installed manually

* [Oh My ZSH!](https://ohmyz.sh/#install)
* [Powerlevel10k](https://github.com/romkatv/powerlevel10k#installation)
  and its [Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)

### MacOS software links

Mac software installation is not automated.

* [iTerm2](https://iterm2.com/)
* [1Password](https://1password.com/downloads/mac/)
* [Nextcloud](https://nextcloud.com/install/)
* [Firefox](https://www.mozilla.org/en-US/firefox/new/)
* [MacVim](https://macvim.org/)
* [MacPorts](https://www.macports.org/install.php)

This also applies to some configuration, so
```bash
sudo cp ~/.dotfiles/us_cat/osx/*.keylayout /Library/Keyboard Layouts
```
log out and back in and apply through settings.

### Ubuntu software packages

The puppet configuration also contains software installation for Ubuntu, via
```
dotfiles software
```
to install the provided selection (requires `sudo`).

It has most recently been tested on jammy.
