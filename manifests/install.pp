#
class carbon_c_relay::install inherits carbon_c_relay {
  
  if $carbon_c_relay::package_manage {

    group { $carbon_c_relay::group:
      ensure => present
    } ->
    user { $carbon_c_relay::user:
      ensure => present,
      groups => $carbon_c_relay::group,
      shell  => '/sbin/nologin'
    }
    
    package { $carbon_c_relay::package_name:
      ensure => $carbon_c_relay::package_ensure
    }
  }
}
