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
      before => Service[$carbon_c_relay::service_name]
    }

    file { $carbon_c_relay::init_file:
      ensure  => $carbon_c_relay::init_file_ensure,
      content => template($carbon_c_relay::init_template),
      before  => Service[$carbon_c_relay::service_name],
      notify  => Service[$carbon_c_relay::service_name]
    }

    service { $carbon_c_relay::service_name:
      ensure     => $carbon_c_relay::service_ensure,
      enable     => $carbon_c_relay::service_enable,
      name       => $carbon_c_relay::service_name,
      hasstatus  => true,
      hasrestart => true,
      provider   => 'init'
    }
  }
}
