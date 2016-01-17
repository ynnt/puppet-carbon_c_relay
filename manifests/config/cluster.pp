#
define carbon_c_relay::config::cluster (
  $cluster_name       = $title,
  $file               = undef,
  $forward_proto      = 'forward',
  $hosts              = {},
  $replication_factor = 1
){

  validate_string($cluster_name)
  validate_integer($replication_factor)

  if ! ($file == undef) {
    validate_string( $file )
  }

  if ! ($forward_proto in ['forward', 'file']) {
    fail("forward_proto '${forward_proto}' is not in ['forward', 'file']")
  }

  unless is_hash( $hosts ) {
    fail("'hosts' param is not a hash")
  }

  concat::fragment { "cluster-${title}":
    target  => $carbon_c_relay::config_file,
    content => template('carbon_c_relay/config/cluster.erb'),
    order   => '02',
  }
}
