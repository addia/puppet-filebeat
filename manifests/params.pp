# == Class filebeat::params
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
class filebeat::params {

  $package_name     = 'filebeat'
  $user             = 'root'
  $group            = 'root'
  $configfile       = '/etc/filebeat/filebeat.yml'
  $config_dir       = '/etc/filebeat/filebeat.d'
  $state_dir        = '/var/lib/filebeat'
  $state_file       = 'filebeat.state'
  $ssl_dir          = '/etc/filebeat/ssl'
  $ssl_key          = 'filebeat.key'
  $ssl_cert         = 'filebeat.crt'
  $cert_insecure    = hiera('elk_stack_log_receiver_cert_insecure')
  $service_name     = "${package_name}.service"
  $systemd_file     = "/usr/lib/systemd/system/${service_name}"
  $log_receiver     = hiera('elk_stack_log_receiver_servers')
  $load_balanced    = true

}


# vim: set ts=2 sw=2 et :
