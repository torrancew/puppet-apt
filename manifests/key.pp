define apt::key( $key_id = $title, $key_path = '', $key_server = 'keys.gnupg.net' ) {
  Class['apt'] -> Apt::Key[$title] ~> Class['apt::update']

  if empty( $key_path ) {
    exec {
      "add remote ${title} apt key":
        command => "apt-key adv --keyserver $key_server --recv-key $key_id",
        unless  => "apt-key list | grep pub | perl -pi -e 's|^.*?/(\\w+).*$|\\1|' | grep -q $key_id",
        path    => ['/usr/local/bin', '/usr/local/sbin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'];
    }
  }

  else {
    exec {
      "add ${title} apt key from file":
        command => $key_path ? {
          /^http:/ => "wget -O- $key_path | gpg --no-default-keyring --keyring /etc/apt/trusted.gpg.d/${title}.gpg --import -",
          default  => "gpg --no-default-keyring --keyring /etc/apt/trusted.gpg.d/${title}.gpg --import ${key_path}",
        },
        path    => ['/usr/local/bin', '/usr/local/sbin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
        creates => "/etc/apt/trusted.gpg.d/${title}.gpg";
    }
  }

}
