# == Class: carbon_c_relay
#
# Full description of class carbon_c_relay here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'carbon_c_relay':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Marc Lambrichs <marc.lambrichs@gmail.com>
#
# === Copyright
#
# Copyright 2016 Marc Lambrichs
#
class carbon_c_relay (
  $package_ensure = $carbon_c_relay::params::package_ensure,
  $package_manage = $carbon_c_relay::params::package_manage,
  $package_name   = $carbon_c_relay::params::package_name,
  $service_enable = $carbon_c_relay::params::service_enable,
  $service_ensure = $carbon_c_relay::params::service_ensure,
  $service_manage = $carbon_c_relay::params::service_manage,
  $service_name   = $carbon_c_relay::params::service_name
) inherits carbon_c_relay::params {

  validate_string($package_ensure)
  validate_bool($package_manage)
  validate_string($package_name)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)

  anchor { 'carbon_c_relay::begin': } ->
  class { '::carbon_c_relay::install': } ->
  class { '::carbon_c_relay::config': } ~>
  class { '::carbon_c_relay::service': } ->
  anchor { 'carbon_c_relay::end': }
}
