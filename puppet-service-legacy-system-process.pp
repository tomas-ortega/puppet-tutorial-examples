package { 'ntp':
    ensure => latest,
}

service { 'ntpd':
    ensure => running,
    enable => true,
    hasstatus => false,
    pattern => 'ntpd',
}
