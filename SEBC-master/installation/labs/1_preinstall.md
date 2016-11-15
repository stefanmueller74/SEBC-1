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
        kernel /boot/vmlinuz-3.10.0-514.el7.x86_64 ro root=UUID=3ed41454-00c8-4803-bf61-2ee88aa54dbf console=hvc0 LANG=en_US.UTF-8 transparent_hugepage=never


#5 Report the network interface attributes
    ifconfig
    
#6 Show forward and reverse host lookups using getent and nslookup
    vi /etc/hosts ### adding hostnames, additionally adding ALL IMCP rule n AWS
        127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
        ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
        54.93.221.40 master
        54.93.129.228 node1
        54.93.221.116 node2
        54.93.96.233 node3
        54.93.126.39 edge
    
    getent hosts
    getent networks
    #install bind-utils which contains "nslookup"
    sudo yum install bind-utils
    # get hostname with "hostname"
    nslookup ip-172-31-18-55.eu-central-1.compute.internal
    
#7 Verify the nscd service is running
    # AS ROOT install NSCD 
    yum install nscd
    service nscd start
    systemctl enable nscd.service
    
#8 Verify the ntpd service is running
    # AS ROOT install ntpd 
    sudo yum install ntp
    service ntpd start
    systemctl enable ntpd.service

