
node 'default' {

  if $facts['identity']['user'] != 'root' {
    include 'userspace'
  }

  if $facts['identity']['user'] == 'root' {
    include 'software'
  }

}

