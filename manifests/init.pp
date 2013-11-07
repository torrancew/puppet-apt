# == Class: apt
#
# A class for managing the base apt folders and files
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
class apt {
  include apt::update

  file {
    'apt.conf':
      path => '/etc/apt/apt.conf',
      mode => '0644';

    'apt.conf.d':
      ensure => directory,
      mode   => '0755';

    'preferences':
      path => '/etc/apt/preferences',
      mode => '0644';

    'preferences.d':
      ensure => directory,
      path   => '/etc/apt/preferences.d',
      mode   => '0755',
      notify => Class['apt::update'];

    'secring.gpg':
      path => '/etc/apt/secring.gpg',
      mode => '0600';

    'sources.list':
      path   => '/etc/apt/sources.list',
      mode   => '0644',
      notify => Class['apt::update'];

    'sources.list.d':
      ensure => directory,
      path   => '/etc/apt/sources.list.d',
      mode   => '0755',
      notify => Class['apt::update'];

    'trustdb.gpg':
      path => '/etc/apt/trustdb.gpg',
      mode => '0600';

    'trusted.gpg':
      path   => '/etc/apt/trusted.gpg',
      mode   => '0600',
      notify => Class['apt::update'];

    'trusted.gpg.d':
      ensure => directory,
      path   => '/etc/apt/trusted.gpg.d',
      mode   => '0755',
      notify => Class['apt::update'];
  }
}

