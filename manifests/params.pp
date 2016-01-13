#
class carbon_c_relay::params {
  $config_file                 = '/etc/carbon-c-relay.conf'
  $group                       = 'carbon-c-relay'
  $init_file                   = '/etc/systemd/system/carbon-c-relay.service'
  $init_file_ensure            = 'file'
  $init_template               = "carbon_c_relay/${init_file}.erb"
  $interface                   = 'all'
  $listen                      = 2003
  $log_dir                     = '/var/log/carbon-c-relay'
  $log_file                    = 'carbon-c-relay.log'
  $output_file                 = undef
  $package_ensure              = present
  $package_manage              = true
  $package_name                = 'carbon-c-relay'
  $pid_dir                     = '/var/run/carbon-c-relay'
  $server_batch_size           = 2500
  $server_queue_size           = 25000
  $service_enable              = true
  $service_ensure              = 'running'
  $service_manage              = true
  $service_name                = $package_name
  $statistics_sending_interval = 60
  $sysconfig_file              = '/etc/sysconfig/carbon-c-relay'
  $user                        = 'carbon-c-relay'
  $worker_threads              = 4
}
