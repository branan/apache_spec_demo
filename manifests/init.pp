class apache (
  $package_name = false
){
  if is_string($package_name) {
    $real_package_name = $package_name
  } else {
    case $::osfamily {
      'RedHat': {
        $real_package_name = 'httpd'
      }
      'Debian': {
        $real_package_name = 'apache2'
      }
      default: {
        fail("unsupported osfamily: $::osfamily")
      }
    }
  }

  package { 'httpd':
    ensure => installed,
    name   => $real_package_name
  }

  service { 'httpd':
    ensure => running,
    name   => $real_package_name
  }
}
