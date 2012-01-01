define apt::key( $key_id = $name, $key_path = '', $key_server = '' ) {
  include apt
  include stdlib

  $default_keyserver = 'keys.gnupg.net'

  if empty( $key_path ) {
    exec {
      "add remote ${name} apt key":
        command => empty( $key_server ) ? {
          true  => "apt-key adv --keyserver $default_keyserver --recv-key $key_id",
          false => "apt-key adv --keyserver $key_server --recv-key $key_id",
        },
        unless  => "apt-key list | grep pub | perl -pi -e 's|^.*?/(\\w+).*$|\\1|' | grep -q $key_id",
        path    => [ "/usr/local/bin", "/usr/local/sbin", "/usr/bin", "/usr/sbin", "/bin", "/sbin" ],
        notify  => Exec['update package list'],
        require => File['trusted.gpg.d'];
    }
  }

  else {
    exec {
      "add ${name} apt key from file":
        command => $key_path ? {
          /^http:/ => "wget -O- $key_path | apt-key add -",
          default  => "apt-key add $key_path",
        },
        path    => [ "/usr/local/bin", "/usr/local/sbin", "/usr/bin", "/usr/sbin", "/bin", "/sbin" ],
        notify  => Exec['update package list'],
        require => File['trusted.gpg.d'];
    }
  }

}
