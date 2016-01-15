#
define carbon_c_relay::config::cluster (
  $cluster_name       = $title,
  $forward_proto      = 'forward',
  $hosts              = [],
  $replication_factor = 1
){

  concat::fragment { "cluster-${title}":
    target  => $carbon_c_relay::config_file,
    content => template('carbon_c_relay/config/cluster.erb'),
    order   => '05',
  }
}
