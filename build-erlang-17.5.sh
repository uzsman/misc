#!/bin/bash
# Pull this file down, make it executable and run it with sudo
# wget 
# chmod u+x build-erlang-17.5.sh
# sudo ./build-erlang-17.5.sh

if [ $(id -u) != "0" ]; then
echo "You must be the superuser to run this script" >&2
exit 1
fi
apt-get update

# Install the build tools (dpkg-dev g++ gcc libc6-dev make)
apt-get -y install build-essential

# automatic configure script builder (debianutils m4 perl)
apt-get -y install autoconf

# Needed for HiPE (native code) support, but already installed by autoconf
# apt-get -y install m4

# Needed for terminal handling (libc-dev libncurses5 libtinfo-dev libtinfo5 ncurses-bin)
apt-get -y install libncurses5-dev

# For building with wxWidgets
apt-get -y install libwxgtk2.8-dev libgl1-mesa-dev libglu1-mesa-dev libpng3

# For building ssl (libssh-4 libssl-dev zlib1g-dev)
apt-get -y install libssh-dev

# Installing other misc dependencies
apt-get -y install xsltproc libxml2-dev libxml2-utils fop

# ODBC support (libltdl3-dev odbcinst1debian2 unixodbc)
apt-get -y install unixodbc-dev
mkdir -p ~/code/erlang
cd ~/code/erlang
 
if [ -e otp_src_17.0.tar.gz ]; then
echo "Good! 'otp_src_17.0.tar.gz' already exists. Skipping download."
else
wget http://www.erlang.org/download/otp_src_17.5.tar.gz 
fi
tar -xvzf otp_src_17.5.tar.gz
chmod -R 777 otp_src_17.5
cd otp_src_17.5
./configure
make
make install

#Replacing shortcuts for default version
cd /usr/bin/
rm -f erl
rm -f erlc
rm -f epmd
rm -f run_erl
rm -f to_erl
rm -f dialyzer
rm -f typer
rm -f escript
rm -f ct_run
ln -s /usr/local/lib/erlang/bin/erl erl
ln -s /usr/local/lib/erlang/bin/erlc erlc
ln -s /usr/local/lib/erlang/bin/epmd epmd
ln -s /usr/local/lib/erlang/bin/run_erl run_erl
ln -s /usr/local/lib/erlang/bin/to_erl to_erl
ln -s /usr/local/lib/erlang/bin/dialyzer dialyzer
ln -s /usr/local/lib/erlang/bin/typer typer
ln -s /usr/local/lib/erlang/bin/escript escript
ln -s /usr/local/lib/erlang/bin/ct_run ct_run
exit 0