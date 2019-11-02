package { 'mysql-server' :
    ensure => installed,
    notify => Service['mysql'],
}

service { 'mysql':
    ensure => running,
    enable => true,
}
