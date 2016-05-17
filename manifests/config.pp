#
class carbon_c_relay::config (
  $allowed_chars               = $carbon_c_relay::allowed_chars,
  $config_file                 = $carbon_c_relay::config_file,
  $listen                      = $carbon_c_relay::listen,
  $log_dir                     = $carbon_c_relay::log_dir,
  $log_file                    = $carbon_c_relay::log_file,
  $package_name                = $carbon_c_relay::package_name,
  $server_batch_size           = $carbon_c_relay::server_batch_size,
  $server_queue_size           = $carbon_c_relay::server_queue_size,
  $service_name                = $carbon_c_relay::service_name,
  $statistics_sending_interval = $carbon_c_relay::statistics_sending_interval,
  $sysconfig_file              = $carbon_c_relay::sysconfig_file,
  $sysconfig_template          = $carbon_c_relay::sysconfig_template,
  $worker_threads              = $carbon_c_relay::worker_threads,
) {

  file { $sysconfig_file:
    ensure  => file,
    content => template($sysconfig_template),
    notify  => Service[$service_name]
  }

  concat { $config_file:
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    notify => Service[$service_name]
  }

  concat::fragment { 'header':
    target  => $config_file,
    order   => '10',
    content => "# ${config_file}: Managed by Puppet."
  }

  $defaults = {
    replication_factor => 1
  }

  create_resources( 'carbon_c_relay::config::cluster', $carbon_c_relay::config_clusters, $defaults )

  create_resources( 'carbon_c_relay::config::match', $carbon_c_relay::config_matches )

  create_resources( 'carbon_c_relay::config::rewrite', $carbon_c_relay::config_rewrites )

}
