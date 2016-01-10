# == Class: carbon_c_relay
#
# Installs, configures and manages carbon-c-relay service.
# Carbon-c-relay is an enhanced C implementation of Carbon relay, aggregator
# and rewriter.
#
# === Parameters
#
# [*package_ensure*]
#   Specifies what state the package should be in.
#   Valid values: present, installed, absent, purged, held, latest.
#   Defaults to: present
#
# [*package_manage*]
#   Specify if the package should be managed by this module.
#   Defaults to: true
#
# [*package_name*]
#   Specify the name this package.
#   Defaults to: 'carbon-c-relay'.
#
# [*service_enable*]
#   Specify if the service should be enabled to start at boot.
#   Valid values: true, false, manual, mask.
#   Defaults to: true
#
# [*service_ensure*]
#   Specify if the service should be running.
#   Valid values: stopped, running.
#   Defaults to: 'running'
#
# [*service_manage*]
#   Specify if the service should be managed by this module.
#   Defaults to: true
#
# [*service_name*]
#   Specifies the name of the service to run
#   Defaults to: 'ccrelay'
#
# === Examples
#
# * Installation, make sure service is running and will be started at boot time:
#  class { 'carbon_c_relay': }
#
# === Authors
#
# Marc Lambrichs <marc.lambrichs@gmail.com>
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
