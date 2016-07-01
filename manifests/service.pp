# == Class filebeat::service
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
class filebeat::service (
  $systemd_file    = $filebeat::params::systemd_file,
  $service_name    = $filebeat::params::service_name,
  $package_name    = $filebeat::params::package_name
) inherits filebeat::params {
  
  notify { "## --->>> Configuring service: ${package_name}": }

  service { $service_name:
    ensure         => running,
    enable         => true,
    hasrestart     => true,
    hasstatus      => true
    }

  }


# vim: set ts=2 sw=2 et :
