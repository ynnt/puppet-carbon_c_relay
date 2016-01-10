#
class carbon_c_relay::install inherits carbon_c_relay {
  
  if $carbon_c_relay::package_manage {
    
    package { $carbon_c_relay::package_name:
      ensure => $carbon_c_relay::package_ensure
    }
  }
}
