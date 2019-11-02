$install_nginx = false

if $install_nginx {
    package { 'nginx':
        ensure => installed,
    }
} else {
    package { 'httpd':
        ensure => installed,
    }
}
