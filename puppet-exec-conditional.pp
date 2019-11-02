exec { 'execute-conditional':
    command => '/bin/echo Hello, this is `whoami` >/tmp/puppet-exec-conditional.txt',
    onlyif => '/bin/ls /tmp/puppet-exec-as-user-root.txt',
}
