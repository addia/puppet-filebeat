# == Class: filebeat
# ===========================
#
#
# Description of the Class:
#
#   Install and configure Filebeat a Lightweight Shipper for all Log Data
#
#
# Document all Parameters:
#
#   Explanation of what this parameter affects and what it defaults to.
#     ensure          = package install status
#     package_name    = the package name to install and configure
#     user            = run as user
#     group           = run as group
#     configfile      = configuration file including path
#     config_dir      = prospector plug-in directory path
#     state_dir       = the state directory
#     state_file      = state file to keep pointer
#     ssl_dir         = certificate file path
#     ssl_key         = certificate key
#     ssl_cert        = certificate file
#     service_name    = systemd service file name
#     systemd_file    = systemd service file including full path
#     log_receiver    = one or more log receiver server names
#     load_balanced   = true or false
#
#
# ===========================
#
#
# == Parameters
# -------------
#
#
# == Authors
# ----------
#
# Author: Addi <addi.abel@gmail.com>
#
#
# == Copyright
# ------------
#
# Copyright:  ©  2016  LR / Addi.
#
#
class filebeat (
  $ensure             = $filebeat::params::ensure,
  $package_name       = $filebeat::params::package_name,
  $user               = $filebeat::params::user,
  $group              = $filebeat::params::group,
  $configfile         = $filebeat::params::configfile,
  $config_dir         = $filebeat::params::config_dir,
  $state_dir          = $filebeat::params::state_dir,
  $state_file         = $filebeat::params::state_file,
  $ssl_dir            = $filebeat::params::ssl_dir,
  $ssl_key            = $filebeat::params::ssl_key,
  $ssl_cert           = $filebeat::params::ssl_cert,
  $service_name       = $filebeat::params::service_name,
  $systemd_file       = $filebeat::params::systemd_file,
  $log_reveiver       = $filebeat::params::log_reveiver,
  $load_balanced      = $filebeat::params::load_balanced
) inherits filebeat::params {

    notify { "## --->>> Installing and configuring ${package_name}": }

    anchor { 'filebeat::begin': } ->
    class { '::filebeat::install': } ->
    class { '::filebeat::config': } ~>
    class { '::filebeat::service': } ->
    anchor { 'filebeat::end': }

}


# vim: set ts=2 sw=2 et :
