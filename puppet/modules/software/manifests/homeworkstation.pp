class software::homeworkstation {

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

