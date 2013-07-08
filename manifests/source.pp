define apt::source(
  $url,
  $release    = $::lsbdistcodename,
  $components = [ 'main' ],
  $source     = false,
) {
  Class['apt'] -> Apt::Source[$title] ~> Class['apt::update']

  file {
    "${title}.list":
      ensure  => present,
      path    => "/etc/apt/sources.list.d/${title}.list",
      mode    => 0644,
      content => template( 'apt/source.list.erb' );
  }
}
