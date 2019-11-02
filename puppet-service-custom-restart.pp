service { 'ntpd':
    ensure => running,
    enable => true,
    restart => '/bin/echo Restarting >> /tmp/puppet-service-custom-restart.log && systemctl restart ntpd',
}
