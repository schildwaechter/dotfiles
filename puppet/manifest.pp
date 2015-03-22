
node 'default' {

  if $::id != 'root' {
    include 'userspace'
  }

  if $::id == 'root' {
    include 'software'
  }

}

