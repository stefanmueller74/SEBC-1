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
    eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9001
        inet 172.31.18.55  netmask 255.255.240.0  broadcast 172.31.31.255
        inet6 fe80::4c7:c8ff:fe06:1799  prefixlen 64  scopeid 0x20<link>
        ether 06:c7:c8:06:17:99  txqueuelen 1000  (Ethernet)
        RX packets 66148  bytes 76604931 (73.0 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 20701  bytes 3081779 (2.9 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

    lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1  (Local Loopback)
        RX packets 10  bytes 844 (844.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 10  bytes 844 (844.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

    
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
    
#7 & 8 

##  Verify the nscd service is running
    # AS ROOT install NSCD 
    yum install nscd
    service nscd start
    systemctl enable nscd.service
    
#8 Verify the ntpd service is running
    # AS ROOT install ntpd 
    sudo yum install ntp
    service ntpd start
    systemctl enable ntpd.service

        [root@ip-172-31-18-55 ec2-user]# service --status-all
        netconsole module not loaded
        Configured devices:
        lo eth0
        Currently active devices:
        lo eth0
        Usage: /etc/init.d/rh-cloud-firstboot {start|stop}
        ● rhnsd.service - LSB: Starts the Spacewalk Daemon
           Loaded: loaded (/etc/rc.d/init.d/rhnsd; bad; vendor preset: disabled)
           Active: active (running) since Mon 2016-11-14 09:39:35 EST; 18h ago
             Docs: man:systemd-sysv-generator(8)
         Main PID: 2213 (rhnsd)
           CGroup: /system.slice/rhnsd.service
                   └─2213 rhnsd

        Nov 14 09:39:35 ip-172-31-18-55 systemd[1]: Starting LSB: Starts the Spacewalk Daemon...
        Nov 14 09:39:35 ip-172-31-18-55 rhnsd[2213]: Spacewalk Services Daemon starting up, check in interval 240 minutes.
        Nov 14 09:39:35 ip-172-31-18-55 rhnsd[1984]: Starting Spacewalk Daemon: [  OK  ]
        Nov 14 09:39:35 ip-172-31-18-55 systemd[1]: Started LSB: Starts the Spacewalk Daemon.
        Nov 14 11:53:22 ip-172-31-18-55.eu-central-1.compute.internal rhnsd[2213]: /etc/sysconfig/rhn/systemid does not exist or is unreadable
        Nov 14 15:53:22 ip-172-31-18-55.eu-central-1.compute.internal rhnsd[2213]: /etc/sysconfig/rhn/systemid does not exist or is unreadable
        Nov 14 19:53:22 ip-172-31-18-55.eu-central-1.compute.internal rhnsd[2213]: /etc/sysconfig/rhn/systemid does not exist or is unreadable
        Nov 14 23:53:22 ip-172-31-18-55.eu-central-1.compute.internal rhnsd[2213]: /etc/sysconfig/rhn/systemid does not exist or is unreadable
        Nov 15 03:53:22 ip-172-31-18-55.eu-central-1.compute.internal rhnsd[2213]: /etc/sysconfig/rhn/systemid does not exist or is unreadable

