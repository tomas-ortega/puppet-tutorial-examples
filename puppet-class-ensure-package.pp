class ensure_ntp_installed {
    package {'ntp':
        ensure => 'installed',
    }

   notice("Excecuted Class!")
}

class { 'ensure_ntp_installed': }
