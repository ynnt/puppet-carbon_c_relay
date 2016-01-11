# == Class: carbon_c_relay
#
# Installs, configures and manages carbon-c-relay service.
# Carbon-c-relay is an enhanced C implementation of Carbon relay, aggregator
# and rewriter.
#
# === Parameters
#
# [*config_file*]
# Specifies where carbon-c-relay reads it's config settings.
#
# [*interface*]
# Specify on which interface (or all interfaces) carbon-c-relay should listen.
#
# [*listen*]
# Specify on which port carbon-c-relay should listen.
#
# [*ouput_file*]
# Specify to which file carbon-c-relay should redirect its output
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
# [*pid_dir*]
#   Specify the directory where the pid file will be written
#   Defaults to: /var/run/carbon-c-relay
#
# [*server_batch_size*]
#
# [*server_queue_size*]
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
# [*statistics_sending_interval*]
# Specify the number of seconds between sending data
#
# [*worker_threads*]
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
  $config_file       = $carbon_c_relay::params::config_file,
  $group             = $carbon_c_relay::params::group,
  $interface         = $carbon_c_relay::params::interface,
  $listen            = $carbon_c_relay::params::listen,
  $output_file       = $carbon_c_relay::params::output_file,
  $package_ensure    = $carbon_c_relay::params::package_ensure,
  $package_manage    = $carbon_c_relay::params::package_manage,
  $package_name      = $carbon_c_relay::params::package_name,
  $pid_dir           = $carbon_c_relay::params::pid_dir,
  $server_batch_size = $carbon_c_relay::params::server_batch_size,
  $server_queue_size = $carbon_c_relay::params::server_queue_size,
  $service_enable    = $carbon_c_relay::params::service_enable,
  $service_ensure    = $carbon_c_relay::params::service_ensure,
  $service_manage    = $carbon_c_relay::params::service_manage,
  $service_name      = $carbon_c_relay::params::service_name,
  $user              = $carbon_c_relay::params::user,
  $worker_threads    = $carbon_c_relay::params::worker_threads
) inherits carbon_c_relay::params {

  validate_string($config_file)
  validate_string($group)
  validate_string($interface)
  validate_integer($listen)
  validate_string($package_ensure)
  validate_bool($package_manage)
  validate_string($package_name)
  validate_string($pid_dir)
  validate_integer($server_batch_size)
  validate_integer($server_queue_size)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_string($user)
  validate_integer($worker_threads)

  anchor { 'carbon_c_relay::begin': } ->
  class { '::carbon_c_relay::install': } ->
  class { '::carbon_c_relay::config': } ~>
  class { '::carbon_c_relay::service': } ->
  anchor { 'carbon_c_relay::end': }
}
