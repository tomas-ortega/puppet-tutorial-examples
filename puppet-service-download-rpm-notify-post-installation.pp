exec { 'Download MySql 5.7':
    command => '/usr/bin/wget -q https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm -O /tmp/mysql57-community-release-el7-9.noarch.rpm',
    provider => shell,
    notify => Exec['Import GPG Key MySQL'],
}

exec { 'Import GPG Key MySQL':
    command => '/usr/bin/rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql',
    notify => Package['Install MySQL'],
}

package{ 'Install MySQL':
        name => mysql-server,
	provider => yum,
	ensure => latest,
	notify => Service['mysqld'],
}

service { 'mysqld':
    ensure => running,
    enable => true,
}
