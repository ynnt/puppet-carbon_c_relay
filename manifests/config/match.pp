#
define carbon_c_relay::config::match (
  $cluster_name = 'blackhole',
  $expression   = $title,
  $stop         = false
){

  concat::fragment { "match-${title}":
    target  => $carbon_c_relay::config_file,
    content => template('carbon_c_relay/config/match.erb'),
    order   => '20'
  }
}

