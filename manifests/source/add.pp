define apt::source::add( $url, $release = $lsbdistcodename, $components = [ 'main' ], $src_repo = false ) {
  include apt

  file {
    "${name}.list":
      ensure  => present,
      path    => "/etc/apt/sources.list.d/${name}.list",
      mode    => 0644,
      content => template( 'apt/new_source.list.erb' ),
      notify  => Exec["update package list"],
      require => File["sources.list.d"];
  }
}
