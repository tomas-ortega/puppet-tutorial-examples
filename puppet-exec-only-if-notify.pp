file { '/tmp/file-puppet-exec-only-notify.txt':
    content => 'Created file by user `whoami`',
    notify => Exec['exec-conditional'],
}

exec { 'exec-conditional':
    command => '/bin/echo File created by exec-conditional by notify! >/tmp/puppet-exec-only-notify-created.txt',
    refreshonly => true,
    logoutput => true,
}
