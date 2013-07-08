define apt::pin( $glob = $title, $release = 'a=testing', $priority = '450' ) {
  Class['apt'] -> Apt::Pin[$title] ~> Class['apt::update']

  file {
    "apt_pinning_${title}":
      ensure  => present,
      path    => "/etc/apt/preferences.d/${title}",
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      content => template( 'apt/pin.erb' );
  }
}

