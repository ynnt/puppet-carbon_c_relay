#
class carbon_c_relay::params {
  $package_ensure = present
  $package_manage = true
  $package_name   = 'carbon-c-relay'
  $service_enable = true
  $service_ensure = 'running'
  $service_manage = true
  $service_name   = 'ccrelay'
}
