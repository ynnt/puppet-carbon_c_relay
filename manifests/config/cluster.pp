#
define carbon_c_relay::config::cluster (
  $channel            = 'carbon_ch',
  $cluster_name       = $title,
  $file               = undef,
  $forward_proto      = 'forward',
  $hosts              = [],
  $replication_factor = undef
){

  validate_string($cluster_name)

  if ! ($file == undef) {
    validate_string( $file )
  }

  if ! ($channel in ['carbon_ch', 'fnv1a_ch']) {
    fail("channel '${channel}' is not in ['carbon_ch', 'fnv1a_ch']")
  }

  if ! ($forward_proto in ['forward', 'file']) {
    fail("forward_proto '${forward_proto}' is not in ['forward', 'file']")
  }

  unless is_array( $hosts ) {
    fail("'hosts' param is not a array")
  }

  concat::fragment { "cluster-${title}":
    target  => $carbon_c_relay::config_file,
    content => template('carbon_c_relay/config/cluster.erb'),
    order   => '20',
  }
}
