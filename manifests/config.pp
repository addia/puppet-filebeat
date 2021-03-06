# == Class filebeat::config
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
class filebeat::config (
  $package_name                = $filebeat::params::package_name,
  $log_receiver                = $filebeat::params::log_receiver,
  $user                        = $filebeat::params::user,
  $group                       = $filebeat::params::group,
  $configfile                  = $filebeat::params::configfile,
  $config_dir                  = $filebeat::params::config_dir,
  $state_dir                   = $filebeat::params::state_dir,
  $state_file                  = $filebeat::params::state_file,
  $ssl_dir                     = $filebeat::params::ssl_dir,
  $ssl_key                     = $filebeat::params::ssl_key,
  $ssl_cert                    = $filebeat::params::ssl_cert,
  $cert_insecure               = $filebeat::params::cert_insecure,
  $service_name                = $filebeat::params::service_name,
  $load_balanced               = $filebeat::params::load_balanced
) {

  include filebeat::params

  notify { "## --->>> Creating config files for: ${package_name}": }

  $filebeat_cert               = "${ssl_dir}/${ssl_cert}"
  $filebeat_key                = "${ssl_dir}/${ssl_key}"

  file { $config_dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755'
    }

  file { $state_dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755'
    }

  file { $ssl_dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755'
    }

  file { "${ssl_dir}/${ssl_key}":
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => hiera('elk_stack_filebeat_key')
    }

  file { "${ssl_dir}/${ssl_cert}":
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => hiera('elk_stack_filebeat_cert')
    }

  ca_cert::ca { 'webops-ca':
    ensure => 'trusted',
    source => 'puppet:///modules/filebeat/webops-ca.crt',
    }

  ca_cert::ca { 'lr_roota1':
    ensure => 'trusted',
    source => 'puppet:///modules/filebeat/lr_roota1.crt',
    }

  ca_cert::ca { 'lr_rootca':
    ensure => 'trusted',
    source => 'puppet:///modules/filebeat/lr_rootca.crt',
    }

  file { $configfile:
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => template('filebeat/filebeat_yml.erb'),
    notify  => Service[$service_name]
    }

  }


# vim: set ts=2 sw=2 et :
