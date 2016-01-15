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

  carbon_c_relay::config::cluster { 'local_carbon':
    hosts => [ '127.0.0.1:2013'],
  }

}
