$package_name = $facts['os']['name'] ? {
  centos => "httpd",
  ubuntu => "apache2",
  default => "httpd"
}

package { 'apache':
  name => $package_name,
  ensure => absent,
  provider => yum,
}

notice("The value is: ${package_name}")
