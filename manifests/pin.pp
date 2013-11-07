# == Define: apt::pin
#
# A defined type for managing apt pins in a robust fashion
#
# === Parameters:
#
# [*ensure*]
#   The state to enforce for this pin
#   Valid values: present, absent
#   Default: present
#
# [*glob*]
#   The package glob to apply this pin to
#   Default: $title
#
# [*criteria*]
#   The criteria this pin matches
#   Default: a=testing
#
# [*priority*]
#   The priority for packages matched by this pin
#   Default: 450
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
define apt::pin(
  $ensure   = present,
  $glob     = $title,
  $criteria = 'a=testing',
  $priority = '450'
) {
  Class['apt'] -> Apt::Pin[$title] ~> Class['apt::update']

  file {
    "apt_pinning_${title}":
      ensure => absent;

    "pin_${title}":
      ensure  => $ensure,
      path    => "/etc/apt/preferences.d/${title}",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template( 'apt/pin.erb' );
  }
}

