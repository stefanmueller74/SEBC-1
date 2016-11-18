# 1 Basic Setup

## List the region, AMI ID, and OS you are using
* Region: Frankfurt
* AMI ID: ami-98a79585
* OS: CentOS 6.6 as getting output from lsb_release -a (despite the AMI description says CentOS-6.5-base-20150305)

<pre><code>
[root@ip-172-31-16-4 ec2-user]# lsb_release -a
Distributor ID: CentOS
Description:    CentOS release 6.6 (Final)
Release:        6.6
Codename:       Final
</code></pre>

## List the volume space you have available on each node

### Node1
<pre><code>
[root@ip-172-31-16-4 KnowHow]#  df / -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup-lv_root
                       14G  1.9G   11G  15% /
</code></pre>
### Node3
<pre><code>
[root@ip-172-31-16-5 ec2-user]# df / -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup-lv_root
                       14G  1.9G   11G  15% /
</code></pre>
### Node3
<pre><code>
[root@ip-172-31-16-6 ec2-user]# df / -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup-lv_root
                       14G  1.9G   11G  15% /
</code></pre>
### Node4
<pre><code>
[root@ip-172-31-16-7 ec2-user]# df / -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup-lv_root
                       14G  1.9G   11G  15% /
</code></pre>
### Node5
<pre><code>
[root@ip-172-31-16-8 ec2-user]# df / -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup-lv_root
                       14G  1.9G   11G  15% /
</code></pre>

## The command and output for yum repolist enabled
<pre><code>
[root@ip-172-31-16-4 ec2-user]# yum repolist enabled
Loaded plugins: fastestmirror
Determining fastest mirrors
epel/metalink                                                                                                                                                         |  23 kB     00:03
 * base: mirror.de.leaseweb.net
 * epel: mirror.de.leaseweb.net
 * extras: ftp-stud.fht-esslingen.de
 * updates: mirror.netcologne.de
base                                                                                                                                                                  | 3.7 kB     00:00
base/primary_db                                                                                                                                                       | 4.7 MB     00:00
epel                                                                                                                                                                  | 4.3 kB     00:00
epel/primary_db                                                                                                                                                       | 5.9 MB     00:00
extras                                                                                                                                                                | 3.4 kB     00:00
extras/primary_db                                                                                                                                                     |  37 kB     00:00
updates                                                                                                                                                               | 3.4 kB     00:00
updates/primary_db                                                                                                                                                    | 3.1 MB     00:00
repo id                                                                 repo name                                                                                                      status
base                                                                    CentOS-6 - Base                                                                                                 6,696
epel                                                                    Extra Packages for Enterprise Linux 6 - x86_64                                                                 12,230
extras                                                                  CentOS-6 - Extras                                                                                                  62
updates                                                                 CentOS-6 - Updates                                                                                                603
repolist: 19,591
</code></pre>

# 2 Users

## Creating Users & Groups

    groupadd democratic
    groupadd social
    adduser bavaria -u 2700 -G social
    adduser saxony -u 2800 -G democratic

## Checking users and groups
    [root@ip-172-31-16-4 ec2-user]# cat /etc/passwd | grep -e social -e democratic -e bavaria  -e saxony
    bavaria:x:2700:2700::/home/bavaria:/bin/bash
    saxony:x:2800:2800::/home/saxony:/bin/bash

    [root@ip-172-31-16-4 ec2-user]#     cat /etc/group | grep -e social -e democratic -e bavaria  -e saxony
    democratic:x:501:saxony
    social:x:502:bavaria
    bavaria:x:2700:
    saxony:x:2800:

