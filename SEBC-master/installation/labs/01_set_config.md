#1 Set swappiness
    echo vm.swappiness=1 >> /etc/sysctl.conf
    sudo sysctl -p /etc/sysctl.conf
    cat /etc/sysctl.conf
    cat /proc/sys/vm/swappiness

#2 Show mount attributes
    mount | grep xfs

#3 Show the reserve space of any non-root, ext-based volumes
    n.a. (see #2)

#4 Show that transparent hugepages is disabled
    cat /sys/kernel/mm/transparent_hugepage/enabled
    # disable TPH at runtime
    echo never > /sys/kernel/mm/transparent_hugepage/enabled
    echo never > /sys/kernel/mm/transparent_hugepage/defrag
    # disable TPH at boottime: add "transparent_hugepage=never"
    /boot/grub/grub.conf 

#5 Report the network interface attributes

#6 Show forward and reverse host lookups using getent and nslookup

#7 Verify the nscd service is running

#8 Verify the ntpd service is running


