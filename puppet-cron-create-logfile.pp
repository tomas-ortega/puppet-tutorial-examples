file { '/tmp/puppet-cron-execution.sh':
    content => "#!/bin/bash\n touch /tmp/cron-file-$(date '+%X')",
    mode => '0755',
}

cron { 'create logfile':
    ensure => present,
    provider => crontab,
    command => '/tmp/puppet-cron-execution.sh',
    user => 'root',
    hour => '*',
    minute => '*/1',
    month => '*',
    monthday => '*',
    weekday => '*',
    require => File['/tmp/puppet-cron-execution.sh'],
}
