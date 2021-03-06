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
  $systemd_file         = $filebeat::params::systemd_file,
  $service_name         = $filebeat::params::service_name,
  $package_name         = $filebeat::params::package_name
) {

  include filebeat::params

  notify { "## --->>> Configuring service: ${package_name}": }

  service { $service_name:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true
    }

  exec { 'remove_initd_filebeat':
    command => 'rm -f /etc/rc.d/init.d/filebeat',
    path    => '/sbin:/bin:/usr/sbin:/usr/bin',
    onlyif  => 'test -x /etc/rc.d/init.d/filebeat',
    }

  }


# vim: set ts=2 sw=2 et :
