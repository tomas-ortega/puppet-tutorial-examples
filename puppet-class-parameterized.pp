class parameterized_selection_class (
    String $webserver,
    Boolean $say_hello = true,
    Enum['running', 'stopped'] $service_state = 'running',
) {
    case $webserver {
        'nginx': {
            notice("Looks like you're using Nginx! Good choice!")
        }
        'apache': {
            notice("Ah, you're an Apache fan, eh?")
        }
        'IIS': {
            notice('Well, somebody has to.')
        }
        default: {
            notice("I'm not sure which webserver you're using!")
        }
    }

    notice("Webserver value: ${webserver}")
    notice("Say Hello: ${say_hello}")
    notice("Service state: ${service_state}")
}

class { 'parameterized_selection_class':
        webserver => 'nginx',
        say_hello => false,
        service_state => 'stopped',
}
