#
class carbon_c_relay::config inherits carbon_c_relay {

  file { $carbon_c_relay::sysconfig_file:
    ensure  => file,
    content => template($carbon_c_relay::sysconfig_template),
    notify  => Service[$carbon_c_relay::service_name]
  }

  concat { $carbon_c_relay::config_file:
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    notify => Service[$carbon_c_relay::service_name]
  }

  concat::fragment { 'header':
    target  => $carbon_c_relay::config_file,
    order   => '01',
    content => "# ${carbon_c_relay::config_file}: Managed by Puppet."
  }

  $defaults = {
    forward_proto => 'forward',
    replication_factor => 1
  }

  create_resources( 'carbon_c_relay::config::cluster', $carbon_c_relay::config_clusters, $defaults)

  create_resources( 'carbon_c_relay::config::rewrite', $carbon_c_relay::config_rewrites)

}
