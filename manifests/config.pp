#
class carbon_c_relay::config inherits carbon_c_relay {

  file { $carbon_c_relay::sysconfig_file:
    ensure  => file,
    content => template($carbon_c_relay::sysconfig_template),
    notify  => Service[$carbon_c_relay::service_name]
  }

}
