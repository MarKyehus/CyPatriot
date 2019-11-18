if [[ $EUID -ne 0 ]]
then
  echo "You must be root to run this script."
  exit 1
fi

#updates
sudo apt-get upgrade
sudo apt-get update

#purges media
cd ..
cd Ubuntu 14.04
chmod -x purge.sh
./purge.sh



