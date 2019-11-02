notice("Apache is set to use ${lookup('apache_worker_factor',
Integer)} workers")

unless lookup('app_armor_enabled', Boolean) {
    exec { '/usr/bin/yum remove apparmor -y': }
}
