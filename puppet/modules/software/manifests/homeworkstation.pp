class software::homeworkstation {

  apt::source { 'mkvtoolnix':
    location    => 'http://www.bunkus.org/ubuntu/trusty/',
    release     => 'trusty',
    repos       => './',
    include_src => true,
    key         => 'D9199745B0545F2E8197062B0F92290A445B9007',
  }->
  package {
    'minidlna':              ensure => installed;
    'mkvtoolnix':            ensure => installed;
    'mkvtoolnix-gui':        ensure => installed;
    'handbrake-gtk':         ensure => installed;
    'easytag':               ensure => installed;
    'lame':                  ensure => installed;
    'libdvdcss2':            ensure => installed;
    'cdparanoia':            ensure => installed;
    'openssh-server':        ensure => installed;
    'samba':                 ensure => installed;
    'google-earth-stable':   ensure => installed;
    'jdownloader-installer': ensure => installed;
  }

  package { 'network-manager-gnome':
    ensure => absent,
  }

}

