if [[ $EUID -ne 0 ]]
then
  echo "You must be root to run this script."
  exit 1
fi
