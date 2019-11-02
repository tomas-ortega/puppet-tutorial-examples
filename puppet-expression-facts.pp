$selinux_activated = false

if $facts['os']['selinux']['enabled'] {
    $_selinux_activated = true
} else {
    $_selinux_activated = false
}

notice("SELinux activated: ${$_selinux_activated}")
