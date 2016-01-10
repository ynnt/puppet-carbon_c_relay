#
class carbon_c_relay::params {
  $config_file                 = '/etc/carbon-c-relay.conf'
  $interface                   = 'all'
  $listen                      = 2003
  $output_file                 = undef
  $package_ensure              = present
  $package_manage              = true
  $package_name                = 'carbon-c-relay'
  $server_batch_size           = 2500
  $server_queue_size           = 25000
  $service_enable              = true
  $service_ensure              = 'running'
  $service_manage              = true
  $service_name                = $module_name
  $statistics_sending_interval = 60
  $worker_threads              = 1
}
