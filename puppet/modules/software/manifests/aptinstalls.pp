class software::aptinstalls {

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
    'python-pip':                ensure => installed;
    'python-virtualenv':         ensure => installed;
    'python3-lxml':              ensure => installed;
    'pidgin':                    ensure => installed;
    'pidgin-gnome-keyring':      ensure => installed;
    'pidgin-libnotify':          ensure => installed;
  }

  package {
    'software-center':           ensure => absent;
    'software-center-aptdaemon-plugins': ensure => absent;
  }

  package {
    'owncloud-client':           ensure => installed;
    'vim-gtk':                   ensure => installed;
    'conky-all':                 ensure => installed;
    'keepassx':                  ensure => installed;
    'seahorse':                  ensure => installed;
    'chromium-browser':          ensure => installed;
    'pepperflashplugin-nonfree': ensure => installed;
    'meld':                      ensure => installed;
    'inkscape':                  ensure => installed;
    'scribus':                   ensure => installed;
    'icc-profiles':              ensure => installed;
    'vlc':                       ensure => installed;
    'encfs':                     ensure => installed;
    'xubuntu-restricted-extras': ensure => installed;
    'texlive-full':              ensure => installed;
    'biber':                     ensure => installed;
    'pdftk':                     ensure => installed;
  }

}

