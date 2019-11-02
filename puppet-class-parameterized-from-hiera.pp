class parameterized_class_hiera (
    String $webserver,
    String $user_name,
) {
    if $webserver == 'nginx' {
        notice("Nginx selected from Hiera!")
    } 

    if $webserver == 'apache' {
        notice("Apache selected from Hiera!")
    }

    notice("Webserver value: ${webserver}")
    notice("User name value: ${user_name}")
}

include parameterized_class_hiera
