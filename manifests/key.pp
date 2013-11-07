# == Define: apt::key
#
# A defined type for managing apt keys in a robust fashion
#
# === Parameters:
#
# [*ensure*]
#   The state to enforce for this key
#   Valid values: present, absent
#   Default: present
#
# [*key_id*]
#   The GPG Key ID to import (Optional) from $key_server
#   Setting $key_path overrides this setting
#   Default: $title
#
# [*key_path*]
#   The path (HTTP or local filesystem) to use to
#   retrieve the GPG key. Overrides $key_id and $key_server
#   Defaults to ''
#
# [*key_server*]
#   The HKP keyserver to retrieve the GPG key from
#   Must be used in combination with $key_id
#   Overridden by $key_path
#   Default: keys.gnupg.net
#
# === Variables:
#
# None
#
# === Examples:
#
# None
#
# === Authors:
#
# * Tray Torrance
#
# === Copyright:
#
# Copyright 2013 Tray Torrance
# unless otherwise noted.
#
define apt::key(
  $ensure     = present,
  $key_id     = $title,
  $key_path   = '',
  $key_server = 'keys.gnupg.net'
) {
  Class['apt'] -> Apt::Key[$title] ~> Class['apt::update']

  if empty( $key_path ) {
    $key_check_cmd = "apt-key list | grep pub | perl -pi -e 's|^.*?/(\\w+).*$|\\1|' | grep -q ${key_id}"

    if $ensure == 'present' {
      exec {
        "add remote ${title} apt key":
          command => "apt-key adv --keyserver ${key_server} --recv-key ${key_id}",
          unless  => $key_check_cmd,
      }
    }
    else {
      exec {
        "remove ${title} apt key":
          command => "apt-key del ${key_id}",
          onlyif  => $key_check_cmd,
      }
    }
  }

  else {
    if $ensure == 'present' {
      $key_download_cmd = $key_path ? {
        /^http:/ => "wget -O- ${key_path} | gpg --no-default-keyring --keyring /etc/apt/trusted.gpg.d/${title}.gpg --import -",
        default  => "gpg --no-default-keyring --keyring /etc/apt/trusted.gpg.d/${title}.gpg --import ${key_path}",
      }

      exec {
        "add ${title} apt key from file":
          command => $key_download_cmd,
          creates => "/etc/apt/trusted.gpg.d/${title}.gpg";
      }
    }
    else {
      file {
        "/etc/apt/trusted.gpg.d/${title}.gpg":
          ensure => absent;
      }
    }
  }

}
