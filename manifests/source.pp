# == Define: apt::source
#
# A defined type for managing apt sources in a robust fashion
#
# === Parameters:
#
# [*ensure*]
#   The state to enforce for this source
#   Valid values: present, absent
#   Default: present
#
# [*url*]
#   The base URL for this source
#
# [*release*]
#   The debian release to search for on this source
#   Default: $::lsbdistcodename
#
# [*components*]
#   An array of components to search for on this source
#   Default: ['main']
#
# [*source*]
#   A boolean that controls whether or not source packages
#   should be indexed from this source
#   Default: false
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
define apt::source(
  $url,
  $ensure     = present,
  $release    = $::lsbdistcodename,
  $components = ['main'],
  $source     = false,
) {
  Class['apt'] -> Apt::Source[$title] ~> Class['apt::update']

  file {
    "${title}.list":
      ensure  => $ensure,
      path    => "/etc/apt/sources.list.d/${title}.list",
      mode    => '0644',
      content => template( 'apt/source.list.erb' );
  }
}
