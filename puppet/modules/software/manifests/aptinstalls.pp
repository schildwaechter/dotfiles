class software::aptinstalls {

  case $::lsbdistcodename {
    'trusty','wily': {
      package {
        'keepass2':              ensure => installed;
        'openjdk-7-jre':         ensure => installed;
      }
      package {
        'software-center':                   ensure => absent;
        'software-center-aptdaemon-plugins': ensure => absent;
      }
    }
    default: {
      package {
        'keepassx':              ensure => installed;
        'openjdk-8-jre':         ensure => installed;
      }
    }
  }

  package {
    'language-pack-de':          ensure => installed;
    'language-pack-en':          ensure => installed;
    'unrar':                     ensure => installed;
    'unzip':                     ensure => installed;
    'synaptic':                  ensure => installed;
    'gksu':                      ensure => installed;
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
    'ruby':                      ensure => installed;
    'ntp':                       ensure => installed;
    'dnsutils':                  ensure => installed;
    'python-dev':                ensure => installed;
    'python-pip':                ensure => installed;
    'python-virtualenv':         ensure => installed;
    'python3-lxml':              ensure => installed;
    'libsasl2-dev':              ensure => installed;
    'ruby-dev':                  ensure => installed;
    'bundler':                   ensure => installed;
    'pidgin':                    ensure => installed;
    'pidgin-gnome-keyring':      ensure => installed;
    'pidgin-libnotify':          ensure => installed;
    'gnupg2':                    ensure => installed;
    'flvstreamer':               ensure => installed;
    'libav-tools':               ensure => installed;
    'zlib1g-dev':                ensure => installed;
    'libpq-dev':                 ensure => installed;
    'coffeescript':              ensure => installed;
    'build-essential':           ensure => installed;
    'libffi-dev':                ensure => installed;
    'libssl-dev':                ensure => installed;
    'libldap2-dev':              ensure => installed;
    'libmysqlclient-dev':        ensure => installed;
    'nodejs':                    ensure => installed;
    'nodejs-legacy':             ensure => installed;
    'npm':                       ensure => installed;
  }

  package {
    'owncloud-client':           ensure => installed;
    'vim-gtk':                   ensure => installed;
    'conky-all':                 ensure => installed;
    'seahorse':                  ensure => installed;
    'chromium-browser':          ensure => installed;
    'pepperflashplugin-nonfree': ensure => installed;
    'meld':                      ensure => installed;
    'inkscape':                  ensure => installed;
    'gimp':                      ensure => installed;
    'scribus':                   ensure => installed;
    'icc-profiles':              ensure => installed;
    'vlc':                       ensure => installed;
    'encfs':                     ensure => installed;
    'xubuntu-restricted-extras': ensure => installed;
    'texlive-full':              ensure => installed;
    'biber':                     ensure => installed;
    'pdftk':                     ensure => installed;
    'usb-creator-gtk':           ensure => installed;
  }

}

