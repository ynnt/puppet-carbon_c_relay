#
class carbon_c_relay::config (
  $allowed_chars               = $carbon_c_relay::allowed_chars,
  $config_file                 = $carbon_c_relay::config_file,
  $group                       = $carbon_c_relay::group,
  $listen                      = $carbon_c_relay::listen,
  $log_dir                     = $carbon_c_relay::log_dir,
  $log_file                    = $carbon_c_relay::log_file,
  $package_name                = $carbon_c_relay::package_name,
  $replication_factor          = $carbon_c_relay::replication_factor,
  $server_batch_size           = $carbon_c_relay::server_batch_size,
  $server_queue_size           = $carbon_c_relay::server_queue_size,
  $service_name                = $carbon_c_relay::service_name,
  $sorted_matches              = $carbon_c_relay::sorted_matches,
  $sorted_rewrites             = $carbon_c_relay::sorted_rewrites,
  $statistics_sending_interval = $carbon_c_relay::statistics_sending_interval,
  $sysconfig_file              = $carbon_c_relay::sysconfig_file,
  $sysconfig_template          = $carbon_c_relay::sysconfig_template,
  $user                        = $carbon_c_relay::user,
  $worker_threads              = $carbon_c_relay::worker_threads,
) {

  file { $sysconfig_file:
    ensure  => file,
    content => template($sysconfig_template),
    notify  => Service[$service_name]
  }

  concat { $config_file:
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0644',
    notify => Service[$service_name]
  }

  ### Set header for config 
  concat::fragment { 'header':
    target  => $config_file,
    order   => '10',
    content => "### ${config_file}: Managed by Puppet."
  }

  $cluster_defaults = {
    replication_factor => $replication_factor
  }

  ### Count the number of clusters and match rules for giving a proper order
  ### to matches and rewrites.
  $nr_of_clusters = count(keys($carbon_c_relay::config_clusters))
  $nr_of_matches  = count(keys($carbon_c_relay::config_matches))

  create_resources( 'carbon_c_relay::config::cluster', $carbon_c_relay::config_clusters, $cluster_defaults )

  ### Sort match rules
  if $sorted_matches {
    $matches = carbon_c_relay_sorted( $carbon_c_relay::config_matches,
                  $nr_of_clusters + 1 )
  } else {
    $matches = $carbon_c_relay::config_matches
  }

  create_resources( 'carbon_c_relay::config::match', $matches )

  ### Sort rewrite rules
  if $sorted_rewrites {
    $rewrites = carbon_c_relay_sorted( $carbon_c_relay::config_rewrites,
                  $nr_of_clusters + $nr_of_matches + 1 )
  } else {
    $rewrites = $carbon_c_relay::config_rewrites
    $rewrite_defaults = { order => $nr_of_clusters + $nr_of_matches + 1 }
  }

  create_resources('carbon_c_relay::config::rewrite', $rewrites, $rewrite_defaults)

  Carbon_c_relay::Config::Cluster<| |> ->
  Carbon_c_relay::Config::Match<| |> ->
  Carbon_c_relay::Config::Rewrite<| |>

}
