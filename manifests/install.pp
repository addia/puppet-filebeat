# == Class filebeat::install
# ===========================
#
#
# Description of the Class:
#
#   This class is meant to be called from init.pp only.
#
#
# ===========================
#
class filebeat::install (
  $ensure        = $filebeat::params::ensure,
  $package_name  = $filebeat::params::package_name
  ) inherits filebeat::params {

  include filebeat::repo

  notify { "## --->>> Installing package: ${package_name}": }

  package { $package_name:
    ensure => $ensure
  }
}


# vim: set ts=2 sw=2 et :
