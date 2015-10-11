class software::homeworkstation {

  package {
    'handbrake-gtk':         ensure => installed;
    'easytag':               ensure => installed;
    'lame':                  ensure => installed;
    'libdvdcss2':            ensure => installed;
    'cdparanoia':            ensure => installed;
    'openssh-server':        ensure => installed;
    'gcdemu':                ensure => installed;
  }


}

