$package_list = [
    'nginx',
    'tomcat',
    'htop',
]

package { $package_list:
    ensure => installed,
}
