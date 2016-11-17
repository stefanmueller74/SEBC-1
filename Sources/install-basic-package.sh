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
