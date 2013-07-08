class apt::update {
  exec {
    'update package list':
      command     => 'apt-get update',
      refreshonly => true,
  }
}

