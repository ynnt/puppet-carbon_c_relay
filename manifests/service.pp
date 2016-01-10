#
class carbon_c_relay::service inherits carbon_c_relay {

  if ! ($carbon_c_relay::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $carbon_c_relay::service_manage == true {
    service { 'carbon_c_relay':
      ensure     => $carbon_c_relay::service_ensure,
      enable     => $carbon_c_relay::service_enable,
      name       => $carbon_c_relay::service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
