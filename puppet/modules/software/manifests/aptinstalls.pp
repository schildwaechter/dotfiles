class software::aptinstalls {

  package {
    'language-pack-de':          ensure => installed;
    'language-pack-en':          ensure => installed;
    'language-pack-nb':          ensure => installed;
    'language-pack-bs':          ensure => installed;
    'language-pack-fr':          ensure => installed;
    'unrar':                     ensure => installed;
    'unzip':                     ensure => installed;
    'synaptic':                  ensure => installed;
    'grc':                       ensure => installed;
    'gparted':                   ensure => installed;
    'vim-nox':                   ensure => installed;
    'htop':                      ensure => installed;
    'inxi':                      ensure => installed;
    'mercurial':                 ensure => installed;
    'git':                       ensure => installed;
    'subversion':                ensure => installed;
    'screen':                    ensure => installed;
    'curl':                      ensure => installed;
    'zsh':                       ensure => installed;
    'ruby':                      ensure => installed;
    'ntp':                       ensure => installed;
    'dos2unix':                  ensure => installed;
    'dnsutils':                  ensure => installed;
    'shellcheck':                ensure => installed;
    'python3-dev':               ensure => installed;
    'python3-pip':               ensure => installed;
    'python3-lxml':              ensure => installed;
    'libsasl2-dev':              ensure => installed;
    'ruby-dev':                  ensure => installed;
    'bundler':                   ensure => installed;
    'gnupg2':                    ensure => installed;
    'flvstreamer':               ensure => installed;
    'ffmpeg':                    ensure => installed;
    'zlib1g-dev':                ensure => installed;
    'libpq-dev':                 ensure => installed;
    'coffeescript':              ensure => installed;
    'build-essential':           ensure => installed;
    'libffi-dev':                ensure => installed;
    'libssl-dev':                ensure => installed;
    'libldap2-dev':              ensure => installed;
    'libmysqlclient-dev':        ensure => installed;
    'nodejs':                    ensure => installed;
    'npm':                       ensure => installed;
    'fonts-powerline':           ensure => installed;
    'cifs-utils':                ensure => installed;
    'libmediainfo0v5':           ensure => installed;
  }

  package {
    'keepassxc':                 ensure => installed;
    'nextcloud-client':          ensure => installed;
    'openjdk-11-jre':            ensure => installed;
    'vim-gtk':                   ensure => installed;
    'conky-all':                 ensure => installed;
    'seahorse':                  ensure => installed;
    'chromium-browser':          ensure => installed;
    'meld':                      ensure => installed;
    'inkscape':                  ensure => installed;
    'gimp':                      ensure => installed;
    'darktable':                 ensure => installed;
    'scribus':                   ensure => installed;
    'icc-profiles':              ensure => installed;
    'pdftk':                     ensure => installed;
    'vlc':                       ensure => installed;
    'ubuntu-restricted-extras':  ensure => installed;
    'texlive-full':              ensure => installed;
    'biber':                     ensure => installed;
    'usb-creator-gtk':           ensure => installed;
    'xfce4-goodies':             ensure => installed;
    'openjfx':                   ensure => installed;
#   'virtualbox-6.1':            ensure => installed;
  }

}

