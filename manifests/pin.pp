define apt::pin( $glob = $name, $release = 'a=testing', $priority = '450' ) {
  file {
    "apt_pinning_${name}":
      ensure  => present,
      path    => "/etc/apt/preferences.d/${name}",
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      content => template( 'apt/pin.erb' ),
      notify  => Exec['update package list'],
      require => File['preferences.d'];
  }
}

