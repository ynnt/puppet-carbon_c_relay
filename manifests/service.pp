# == Class carbon_c_relay::service
#
#
class carbon_c_relay::service inherits carbon_c_relay {

  if ! ($carbon_c_relay::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $carbon_c_relay::service_manage == true {

    file { $carbon_c_relay::log_dir:
      ensure => directory,
      group  => $carbon_c_relay::group,
      mode   => '0644',
      owner  => $carbon_c_relay::user,
    }

    File[$carbon_c_relay::log_dir] ~> Service[$carbon_c_relay::service_name]

    file { $carbon_c_relay::service_file:
      ensure  => file,
      group   => 'root',
      mode    => '0644',
      owner   => 'root',
      content => template($carbon_c_relay::service_template),
    }

    Exec { '/bin/systemctl daemon-reload':
      subscribe   => File[$carbon_c_relay::service_file],
      refreshonly => true,
      user        => 'root'
    } ~>

    service { $carbon_c_relay::service_name:
      ensure   => $carbon_c_relay::service_ensure,
      enable   => $carbon_c_relay::service_enable,
      name     => $carbon_c_relay::service_name,
      provider => 'systemd',
    }
  }
}
