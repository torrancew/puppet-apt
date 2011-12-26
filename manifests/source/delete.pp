define apt::source::delete( ) {
  include apt

  file {
    "${name}.list":
      path    => "/etc/apt/sources.list.d/${name}.list",
      ensure  => absent,
      notify  => Exec['update package list'],
      require => File['sources.list.d'];
  }
}
