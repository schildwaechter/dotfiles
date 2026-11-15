
node 'default' {

  if $facts['identity']['user'] != 'root' {
    include 'userspace'
  }

}

