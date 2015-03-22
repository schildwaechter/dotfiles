class software::sysconfigchanges {

  exec { 'vimasdefault':
    path    => ['/usr/bin','/bin','/usr/sbin'],
    command => 'update-alternatives --set editor /usr/bin/vim.nox',
    unless  => 'test /etc/alternatives/editor -ef /usr/bin/vim.nox',
    require => Class['Software::Aptinstalls'],
  }

  exec { 'uscat_evdev_xml.py':
    path    => ['/usr/bin','/bin','/usr/sbin'],
    command => "sudo python ${::dotfilespath}/bin/uscat_evdev_xml.py",
    unless  => 'grep CaT /usr/share/X11/xkb/rules/evdev.xml',
    require => Class['Software::Aptinstalls'],
  }

  if $software::us_cat_default {
    augeas { 'default_keyboard':
      context => '/files/etc/default/keyboard',
      changes => [
        "set XKBLAYOUT '\"us_cat\"'",
        "set XKBOPTIONS '\"terminate:ctrl_alt_bksp\"'",
      ],
    }
  }

  augeas { 'default_apport':
    context => '/files/etc/default/apport',
    changes => [
      "set enabled 0",
    ],
  }

  augeas { 'ipv6_privacy':
    context => '/files/etc/sysctl.conf',
    changes => [
      'set net.ipv6.conf.default.use_tempaddr 2',
      'set net.ipv6.conf.eth0.use_tempaddr 2',
      'set net.ipv6.conf.eth1.use_tempaddr 2',
      'set net.ipv6.conf.eth2.use_tempaddr 2',
      'set net.ipv6.conf.wlan0.use_tempaddr 2',
      'set net.ipv6.conf.wlan1.use_tempaddr 2',
      'set net.ipv6.conf.wlan2.use_tempaddr 2',
    ],
  }


}

