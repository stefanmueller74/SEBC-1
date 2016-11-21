###############################################################
# SERVICES
# Installing 
# ... nscd
# ... ntp
# ... mysql (TBD)
# ... tbd
################################################################

echo "##################################"
echo "Installing: NSCD Service"
sudo yum -y install bind-utils
sudo yum -y install nscd
service nscd start
systemctl enable nscd.service
echo "SERVICE NSCD done "
echo "##################################"


echo "##################################"
echo "Installing: NSCD service"
sudo yum -y install ntp
sudo yum -y install nscd
service nscd start
systemctl enable ntpd.service
echo "SERVICE NTP done "
echo "##################################"
