$buffer_pool = $facts['memory']['system']['total_bytes'] * 3/4
$total_system_memory = $facts['memory']['system']['total_bytes']

notice("Total memory in system is: ${total_system_memory}")
notice("innodb_buffer_pool_size=${buffer_pool}")

notice("My hostname is ${facts['hostname']}")
notice("My FQDN is ${facts['fqdn']}")
notice("My IP is ${facts['networking']['ip']}")
