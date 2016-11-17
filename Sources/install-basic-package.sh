###############################################################
# Basic Pacakges
# Installing 
# ... wget
# ... mlocate
# ... yum-utils
################################################################

echo "##################################"
echo "Installing: wget"
sudo yum -y install wget
echo "wget done "
echo "##################################"

echo "##################################"
echo "Installing: mlocate"
sudo yum -y install mlocate
sudo updatedb 
echo "mlocate done "
echo "##################################"

echo "##################################"
echo "Installing: mlocate"
sudo sudo yum -y install yum-utils
echo "yum-utils done "
echo "##################################"


################################################################
# Services
################################################################


echo "##################################"
echo "Installing: mlocate"
sudo yum -y install bind-utils
sudo yum -y install nscd
service nscd start
systemctl enable nscd.service
echo "SERVICE NSCD done "
echo "##################################"


echo "##################################"
echo "Installing: mlocate"
sudo yum -y install ntp
sudo yum -y install nscd
service nscd start
systemctl enable ntpd.service
echo "SERVICE NTP done "
echo "##################################"
