exec { 'say-hello-as-root':
    command => '/bin/echo Hello, this is `whoami` >/tmp/puppet-exec-as-user-root.txt',
    user => 'root',
    creates => '/tmp/puppet-exec-as-user-root.txt',
}
