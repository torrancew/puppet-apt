# == Class: apt::update
#
# A class for managing apt updates
#
# === Parameters
#
# None
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
# Copyright 2013, Tray Torrance
# unless otherwise noted.
#
class apt::update {
  Class['apt'] -> Class['apt::update']

  exec {
    'update package list':
      command     => 'apt-get update',
      refreshonly => true;
  }
}

