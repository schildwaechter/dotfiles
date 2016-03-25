class software (
    $us_cat_default  = false,
    $homeworkstation = false,
  ){

  class { 'software::aptconfig': }

  class { 'software::aptinstalls':
    require => Class['software::aptconfig']
  }

  class { 'software::otherinstalls':
    require => Class['software::aptinstalls']
  }

  if $homeworkstation {
    class { 'software::homeworkstation':
      require => Class['software::otherinstalls']
    }
  }

  class {'software::sysconfigchanges':
    require => Class['software::otherinstalls']
  }

}

