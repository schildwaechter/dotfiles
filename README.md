# CaT's dotfiles and more

## dotfiles

This folder contains all of CaT's public dotfiles.
They can be installed using puppet.

This has most recently been tested on both Debian 12 and macOS 13.

### install

The repository uses submodules
```
git clone https://github.com/schildwaechter/dotfiles ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update
```

Install [puppet](https://www.puppet.com/docs/puppet/7/install_agents.html)
```bash
apt install puppet-agent
```
Or, once Puppet decides to support current Debian, this should work again
```bash
wget -q "https://apt.puppetlabs.com/puppet-release-$(lsb_release -cs).deb"
dpkg -i "puppet-release-$(lsb_release -cs).deb";
rm "puppet-release-$(lsb_release -cs).deb";
apt-get update;
apt-get -y install puppet-agent;
```

Or use Homebrew for MacOS.

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

### MacOS

See [MacOS.md](MacOS.md).

### Ubuntu software packages

The puppet configuration also contains software installation for Ubuntu, via
```
dotfiles software
```
to install the provided selection (requires `sudo`).

It has most recently been tested on jammy.
