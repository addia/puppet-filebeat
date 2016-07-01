# == Class filebeat::repo
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
class filebeat::repo (
  $package_name       = $filebeat::params::package_name
) inherits filebeat::params {

  $arch               = $::architecture

  notify { "## --->>> Creating repo for: ${package_name}": }

  case $::osfamily {
    'RedHat': {
      yumrepo { 'beats':
        ensure        => 'present',
        descr         => 'Elastic Beats Repository',
        baseurl       => "https://packages.elastic.co/beats/yum/el/${arch}",
        gpgcheck      => 1,
        gpgkey        => 'https://packages.elastic.co/GPG-KEY-elasticsearch',
        enabled       => 1,
        }
      }
    'Debian': {
      apt::source { 'beats':
        location      => 'https://packages.elastic.co/beats/apt',
        release       => 'stable',
        repos         => 'main',
        key           => 'D88E42B4',
        key_source    => 'https://packages.elastic.co/GPG-KEY-elasticsearch',
        }
      }

    'Archlinux': {
      fail("\"${::osfamily}\" the \"${package_name}\" is provided via the AUR repository.")
      }
      
    default: {
      fail("\"${package_name}\" provides no repository information for OSfamily \"${::osfamily}\"")
      }
    }

  }


# vim: set ts=2 sw=2 et :
