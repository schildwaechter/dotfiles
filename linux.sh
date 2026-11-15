#!/usr/bin/env bash
#
# Linux system setup script, detects and respects distribution.
# Should be with sudo from normal account.

set -euo pipefail

###############################################################################
# defaults                                                                    #
###############################################################################

RUN_ALL=false
RUN_PACKAGES=false
RUN_LOCALE=false
RUN_KEYBOARD=false
SET_DEFAULT_KEYBOARD=false
RUN_SYSCTL=false
RUN_SUDOERS=false
RUN_SHELL=false
RUN_LIMA=false

###############################################################################
# usage                                                                       #
###############################################################################

usage() {
  cat <<'EOF'
Usage: linux.sh [OPTIONS]

Linux system setup for Debian/Ubuntu and Arch/CachyOS.
Must be run with sudo.

Options:
  -a, --all                    Run all setup steps for this OS
  -p, --packages               Install distro-specific packages and sources
  -l, --locale                 Generate locales
  -k, --keyboard               Install custom XKB keyboard layouts
      --set-default-keyboard   Also set us_cat as the system default layout
  -s, --sysctl                 Apply sysctl settings
  -S, --sudoers                Enable sudo insults
  -z, --shell                  Set zsh as the default shell
  -L, --lima                   Install or update Lima VM
  -h, --help                   Show this help message

Examples:
  sudo ./linux.sh --all
  sudo ./linux.sh --packages --locale --shell
  sudo ./linux.sh --keyboard --set-default-keyboard
EOF
}

###############################################################################
# argument parsing                                                            #
###############################################################################

while [[ $# -gt 0 ]]; do
  case "$1" in
    -a|--all)
      RUN_ALL=true
      shift
      ;;
    -p|--packages)
      RUN_PACKAGES=true
      shift
      ;;
    -l|--locale)
      RUN_LOCALE=true
      shift
      ;;
    -k|--keyboard)
      RUN_KEYBOARD=true
      shift
      ;;
    --set-default-keyboard)
      SET_DEFAULT_KEYBOARD=true
      shift
      ;;
    -s|--sysctl)
      RUN_SYSCTL=true
      shift
      ;;
    -S|--sudoers)
      RUN_SUDOERS=true
      shift
      ;;
    -z|--shell)
      RUN_SHELL=true
      shift
      ;;
    -L|--lima)
      RUN_LIMA=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ "$RUN_ALL" == false && \
      "$RUN_PACKAGES" == false && \
      "$RUN_LOCALE" == false && \
      "$RUN_KEYBOARD" == false && \
      "$RUN_SYSCTL" == false && \
      "$RUN_SUDOERS" == false && \
      "$RUN_SHELL" == false && \
      "$RUN_LIMA" == false ]]; then
  echo "No action specified." >&2
  usage >&2
  exit 1
fi

###############################################################################
# environment                                                                 #
###############################################################################

if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  echo "This script must be run as root or with sudo." >&2
  exit 1
fi

# shellcheck source=/dev/null
source /etc/os-release

OS_FAMILY=""
CODENAME="${VERSION_CODENAME:-}"
TARGET_USER="${SUDO_USER:-}"

case "${ID:-}" in
  debian|ubuntu)
    OS_FAMILY="debian"
    ;;
  arch|cachyos)
    OS_FAMILY="arch"
    ;;
  *)
    if [[ "${ID_LIKE:-}" == *"debian"* || "${ID_LIKE:-}" == *"ubuntu"* ]]; then
      OS_FAMILY="debian"
    elif [[ "${ID_LIKE:-}" == *"arch"* ]]; then
      OS_FAMILY="arch"
    else
      echo "Unsupported distribution: ${ID:-unknown}" >&2
      exit 1
    fi
    ;;
esac

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

if [[ -z "$TARGET_USER" || "$TARGET_USER" == "root" ]]; then
  TARGET_USER="$USER"
fi

if [[ "$TARGET_USER" == "root" ]]; then
  TARGET_USER=""
fi

###############################################################################
# helpers                                                                     #
###############################################################################

section() {
  echo ""
  echo "==> $1"
}

require_non_root_target() {
  if [[ -z "$TARGET_USER" ]]; then
    echo "Please run this script via sudo from your regular user account." >&2
    exit 1
  fi
}

###############################################################################
# packages                                                                    #
###############################################################################

install_packages_debian() {
  section "Configuring Debian/Ubuntu apt sources"

  mkdir -p /etc/apt/keyrings

  if [[ ! -f /etc/apt/sources.list.d/virtualbox.list ]]; then
    wget -q "https://www.virtualbox.org/download/oracle_vbox_2016.asc" -O - \
      | gpg --dearmor --yes \
      > /usr/share/keyrings/oracle-vbox-2016.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-vbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian ${CODENAME} contrib" \
      > /etc/apt/sources.list.d/virtualbox.list
  fi

  if [[ ! -f /etc/apt/sources.list.d/vscode.list ]]; then
    wget -qO - "https://packages.microsoft.com/keys/microsoft.asc" \
      | gpg --dearmor --yes \
      > /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
      > /etc/apt/sources.list.d/vscode.list
  fi

  section "Updating apt package index"
  apt-get update

  section "Installing packages"
  local packages=(
    build-essential bundler cifs-utils coffeescript curl dnsutils dos2unix
    ffmpeg flvstreamer fzf git gnupg2 grc htop httpie inxi libffi-dev
    libldap2-dev libmediainfo0v5 libpq-dev libsasl2-dev libssl-dev
    default-libmysqlclient-dev mercurial neofetch ntp pipx python3-dev
    python3-lxml python3-pip ruby ruby-dev screen shellcheck sshfs
    subversion unrar unzip vim-nox zlib1g-dev zsh
    chromium conky-all darktable gdu gimp gparted gparted inkscape keepassxc
    meld pdftk scribus seahorse simple-scan synaptic texlive-full biber vlc
    xfce4-goodies icc-profiles fonts-powerline exfat-fuse vim-gtk3 golang-go
    direnv btop jq code
  )
  apt-get install -y "${packages[@]}"

  section "Setting vim.nox as default editor"
  update-alternatives --set editor /usr/bin/vim.nox

  if [[ "${ID:-}" == "ubuntu" ]]; then
    section "Disabling apport"
    sed -i 's/^enabled=.*/enabled=0/' /etc/default/apport
    systemctl stop apport.service 2>/dev/null || true
    systemctl disable apport.service 2>/dev/null || true
  fi
}

install_packages_arch() {
  section "Updating system and installing packages"

  require_non_root_target

  pacman -Syu --needed --noconfirm \
    zsh \
    ttf-meslo-nerd-font \
    ghostty neovim tree-sitter-cli wl-clipboard \
    python-pip python-lxml \
    gopls bash-language-server shellcheck \
    lua-language-server python-lsp-server markdownlint-cli2 \
    yaml-language-server yad uv httpie dos2unix go air \
    texlive-bin texlive-latex texlive-latexrecommended texlive-latexextra \
    texlive-fontsrecommended texlive-binextra texlive-fontsextra \
    texlive-langgerman texlive-langenglish texlive-langeuropean \
    texlive-plaingeneric \
    htop gparted tmux screen gdu bottom jq bat fzf \
    inkscape gimp darktable scribus qpdf simple-scan \
    polkit-gnome seahorse gnome-keyring \
    docker docker-compose docker-buildx \
    opentofu kubectl krew kubectx fluxcd argocd kind \
    spotify-launcher nextcloud-client \
    vlc vlc-plugins-all ffmpeg

  section "Enabling services"
  systemctl enable --now docker.service
  su - "$TARGET_USER" -c 'systemctl --user enable --now gcr-ssh-agent.socket' || true
  su - "$TARGET_USER" -c 'systemctl --user enable --now ssh-agent.service' || true

  section "Adding ${TARGET_USER} to docker group"
  usermod -aG docker "$TARGET_USER"

  echo "Note: group membership changes require a logout/login to take effect."
}

install_packages() {
  case "$OS_FAMILY" in
    debian) install_packages_debian ;;
    arch)   install_packages_arch ;;
  esac
}

###############################################################################
# locale                                                                      #
###############################################################################

configure_locale() {
  section "Generating locales"

  local locales=(
    "de_DE.UTF-8 UTF-8"
    "de_DE ISO-8859-1"
    "de_DE@euro ISO-8859-15"
    "en_GB.UTF-8 UTF-8"
    "en_GB ISO-8859-1"
    "en_US.UTF-8 UTF-8"
    "en_US ISO-8859-1"
    "nb_NO.UTF-8 UTF-8"
    "nb_NO ISO-8859-1"
  )

  ensure_locale() {
    local locale_entry="$1"
    if grep -qxF "$locale_entry" /etc/locale.gen 2>/dev/null; then
      return 0
    fi
    if grep -qxF "# $locale_entry" /etc/locale.gen 2>/dev/null; then
      sed -i "s/^# $locale_entry$/$locale_entry/" /etc/locale.gen
    else
      echo "$locale_entry" >> /etc/locale.gen
    fi
  }

  for loc in "${locales[@]}"; do
    ensure_locale "$loc"
  done

  locale-gen
}

###############################################################################
# keyboard                                                                    #
###############################################################################

configure_keyboard() {
  section "Installing custom XKB layouts"
  install -m 644 "$DOTFILES/us_cat/us_cat" /usr/share/X11/xkb/symbols/us_cat
  if [[ -f "$DOTFILES/us_cat/de_cat" ]]; then
    install -m 644 "$DOTFILES/us_cat/de_cat" /usr/share/X11/xkb/symbols/de_cat
  fi

  section "Registering layouts in evdev.xml"
  python3 "$DOTFILES/us_cat/evdev_xml_entry.py"

  if [[ "$SET_DEFAULT_KEYBOARD" == true ]]; then
    section "Setting us_cat as the system default keyboard layout"
    if [[ -f /etc/default/keyboard ]]; then
      sed -i 's/^XKBLAYOUT=.*/XKBLAYOUT="us_cat"/' /etc/default/keyboard
      if ! grep -q '^XKBOPTIONS=' /etc/default/keyboard; then
        echo 'XKBOPTIONS="terminate:ctrl_alt_bksp"' >> /etc/default/keyboard
      else
        sed -i 's/^XKBOPTIONS=.*/XKBOPTIONS="terminate:ctrl_alt_bksp"/' /etc/default/keyboard
      fi
    else
      cat > /etc/default/keyboard <<'EOF'
XKBMODEL="pc105"
XKBLAYOUT="us_cat"
XKBVARIANT=""
XKBOPTIONS="terminate:ctrl_alt_bksp"
BACKSPACE="guess"
EOF
    fi
  fi
}

###############################################################################
# sysctl                                                                      #
###############################################################################

configure_sysctl() {
  section "Applying sysctl settings"

  local sysctl_file="/etc/sysctl.d/99-cat-dotfiles.conf"
  cat > "$sysctl_file" <<'EOF'
# Enable IPv6 privacy extensions for new interfaces
net.ipv6.conf.default.use_tempaddr = 2
EOF

  for iface in /proc/sys/net/ipv6/conf/*/use_tempaddr; do
    if [[ -e "$iface" ]]; then
      echo 2 > "$iface"
    fi
  done

  sysctl --system
}

###############################################################################
# sudoers                                                                     #
###############################################################################

configure_sudoers() {
  section "Enabling sudo insults"
  local drop_in="/etc/sudoers.d/insults"
  cat > "$drop_in" <<'EOF'
Defaults insults
EOF
  chmod 440 "$drop_in"
  visudo -c
}

###############################################################################
# shell                                                                       #
###############################################################################

configure_shell() {
  section "Setting zsh as default shell"
  require_non_root_target

  local zsh_path="${ZSH_PATH:-/usr/bin/zsh}"
  local current_shell
  current_shell=$(getent passwd "$TARGET_USER" | cut -d: -f7)

  if [[ "$current_shell" == "$zsh_path" ]]; then
    echo "Default shell for ${TARGET_USER} is already ${zsh_path}."
    return 0
  fi

  if [[ ! -x "$zsh_path" ]]; then
    echo "zsh not found at ${zsh_path}." >&2
    exit 1
  fi

  chsh -s "$zsh_path" "$TARGET_USER"
}

###############################################################################
# lima                                                                        #
###############################################################################

install_lima() {
  section "Installing Lima"
  require_non_root_target

  for cmd in curl jq tar; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "Required tool not found: $cmd" >&2
      exit 1
    fi
  done

  local version
  version=$(curl -fsSL https://api.github.com/repos/lima-vm/lima/releases/latest | jq -r .tag_name)

  section "Installing Lima ${version}"
  curl -fsSL "https://github.com/lima-vm/lima/releases/download/${version}/lima-${version:1}-$(uname -s)-$(uname -m).tar.gz" | tar Cxzvm /usr/local

  section "Installing additional guest agents"
  curl -fsSL "https://github.com/lima-vm/lima/releases/download/${version}/lima-additional-guestagents-${version:1}-$(uname -s)-$(uname -m).tar.gz" | tar Cxzvm /usr/local

  section "Verifying Lima installation"
  su - "$TARGET_USER" -c 'limactl --version'
}

###############################################################################
# main                                                                        #
###############################################################################

if [[ "$RUN_ALL" == true ]]; then
  install_packages
  configure_locale
  configure_keyboard
  configure_sysctl
  configure_sudoers
  configure_shell
  install_lima
else
  [[ "$RUN_PACKAGES" == true ]] && install_packages
  [[ "$RUN_LOCALE" == true ]]   && configure_locale
  [[ "$RUN_KEYBOARD" == true ]] && configure_keyboard
  [[ "$RUN_SYSCTL" == true ]]   && configure_sysctl
  [[ "$RUN_SUDOERS" == true ]]  && configure_sudoers
  [[ "$RUN_SHELL" == true ]]    && configure_shell
  [[ "$RUN_LIMA" == true ]]     && install_lima
fi

echo ""
echo "Done."
