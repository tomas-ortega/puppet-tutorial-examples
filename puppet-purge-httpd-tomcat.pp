package { 'tomcat':
        ensure  => purged,
}

package { 'httpd': 
    ensure => purged,
}
