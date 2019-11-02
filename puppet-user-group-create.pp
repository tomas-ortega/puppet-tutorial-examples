group { 'developers':
    ensure => present,
    gid => 3000,
}

user { 'student': 
    ensure => present,
    password => Sensitive('12345'),
    uid => '3001',
    home => '/home/student',
    shell => '/bin/bash',
    groups => ['developers'],
}
