define apt::key::delete( $key_id = $name ) {
  include apt

  exec {
    'delete apt key by id':
      command => "apt-key del $key_id",
      path    => [ "/usr/local/bin", "/usr/local/sbin", "/usr/bin", "/usr/sbin", "/bin", "/sbin" ],
      notify  => Exec['update package list'];
  }
}

