exec { 'dump-trace-ls-to-file':
    cwd => '/tmp/',
    command => '/usr/bin/ls -la > puppet-exec-result-ls.txt',
    creates => '/tmp/puppet-exec-result-ls.txt',
}
