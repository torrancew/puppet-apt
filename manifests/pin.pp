define apt::pin( $glob = $name, $release = 'a=testing', $priority = '700' ) {
  file {
    "apt_pinning_${name}":
      path    => "/etc/apt/preferences.d/${name}",
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      content => template( 'apt/pin.erb' );
  }
}

