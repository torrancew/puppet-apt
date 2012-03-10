class apt {
  file {
    'apt.conf':
      path => '/etc/apt/apt.conf',
      mode => 0644;

    'apt.conf.d':
      path   => '/etc/apt/apt.conf.d',
      ensure => directory,
      mode   => 0755;

    'preferences':
      path => '/etc/apt/preferences',
      mode => 0644;

    'preferences.d':
      path   => '/etc/apt/preferences.d',
      ensure => directory,
      mode   => 0755;

    'secring.gpg':
      path => '/etc/apt/secring.gpg',
      mode => 0600;

    'sources.list':
      path => '/etc/apt/sources.list',
      mode => 0644;

    'sources.list.d':
      path   => '/etc/apt/sources.list.d',
      ensure => directory,
      mode   => 0755;

    'trustdb.gpg':
      path => '/etc/apt/trustdb.gpg',
      mode => 0600;

    'trusted.gpg':
      path => '/etc/apt/trusted.gpg',
      mode => 0600;

    'trusted.gpg.d':
      path   => '/etc/apt/trusted.gpg.d',
      ensure => directory,
      mode   => 0755;
  }

  $package_watch_paths = [
    File['sources.list'],
    File['sources.list.d'],
    File['preferences.d'],
  ]

  exec {
    'update package list':
      command     => '/usr/bin/aptitude update',
      refreshonly => true,
      subscribe   => $package_watch_paths;

    'clean package cache':
      command     => '/usr/bin/aptitude clean',
      refreshonly => true;
  }
}

