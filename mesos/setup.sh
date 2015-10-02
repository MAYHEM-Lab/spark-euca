#!/bin/bash
apt-get update
apt-get --yes --force-yes install build-essential
apt-get --yes --force-yes install python-dev python-boto
apt-get --yes --force-yes install libcurl4-nss-dev
apt-get --yes --force-yes install libsasl2-dev
apt-get --yes --force-yes install maven

if [[ "x$MESOS_SETUP_VERSION" == "x0.21.1" ]] ; then
apt-get --yes --force-yes install libapr1-dev
apt-get --yes --force-yes install libsvn-dev
fi

download_method=$1
if [[ "$DOWNLOAD_METHOD" == "git" ]] ; then
apt-get --yes --force-yes install autoconf
apt-get --yes --force-yes install libtool
fi



#Building Mesos
# Change working directory.
cd /root/mesos-$MESOS_SETUP_VERSION

# Bootstrap (***Skip this if you are not building from git repo***).
#./bootstrap

# Configure and build.
mkdir /root/mesos-installation/
mkdir build
cd build
echo "Running configure..."
../configure --prefix=/root/mesos-installation/
echo "Running make..."
make -j 2

# Install (***Optional***).

echo "Installing...""
make -j 2 install

#TODO: SET LD_LIBRARY_PATH CORRECTLY ON EMI
#delete previous LD_LIBRARY_PATH
sed -i '/LD_LIBRARY_PATH=/d'  /etc/environment
echo "LD_LIBRARY_PATH=/root/mesos-installation/lib" >> /etc/environment
export LD_LIBRARY_PATH=/root/mesos-installation/lib/
echo "Done!"

# Run test suite -- Also builds example frameworks
#make check #Run make check at the end because some tests fail (VERSION 0.18.1)

