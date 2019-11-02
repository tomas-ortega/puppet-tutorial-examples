$package_name = $facts['os']['name'] ? {
  centos => "httpd",
  ubuntu => "apache2",
  default => "Pakito"
}

package { 'tomcat':
  ensure => latest,
}

package { 'apache':
  name => $package_name,
  ensure => latest,
  provider => yum,
  require => Package['tomcat'],
}
