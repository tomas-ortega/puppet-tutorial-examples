$kernel_info = $facts['kernel']

notice("Kernel: ${kernel_info}")
notice("OS architecture: ${facts['os']['architecture']}")
notice("OS Distro Codename: ${facts['os']['distro']['codename']}")
