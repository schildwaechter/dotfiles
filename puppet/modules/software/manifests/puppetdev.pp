class software::puppetdev {

  package { 'librarian-puppet':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'r10k':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'puppet-lint':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'rspec-puppet':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'puppetlabs_spec_helper':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'metadata-json-lint':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'puppet-syntax':
    ensure   => latest,
    provider => 'gem',
  }

  class { 'vagrant': }

  vagrant::plugin { 'vagrant-cachier':
    user => 'cat'
  }

  vagrant::plugin { 'vagrant-vbox-snapshot':
    user => 'cat'
  }

  vagrant::plugin { 'vagrant-hostmanager':
    user => 'cat'
  }

  vagrant::plugin { 'vagrant-vbguest':
    user => 'cat'
  }
}

