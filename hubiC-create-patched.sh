#!/bin/sh

set -u
set -e

patchedHubiC=hubiC-browser-0.3.8-patched-ubuntu1204.tar.gz

HUBIC_DL=http://hubic.labs.ovh.com/hubic/download/0.3.8/hubiC-browser-0.3.8.tar.gz
libXfixes=http://ftp.fr.debian.org/debian/pool/main/libx/libxfixes/libxfixes3_4.0.5-1_i386.deb
libXi=http://ftp.fr.debian.org/debian/pool/main/libx/libxi/libxi6_1.3-7_i386.deb
libXinerama=http://ftp.de.debian.org/debian/pool/main/libx/libxinerama/libxinerama1_1.1-3_i386.deb

echo "Please note this script is designed to workaround the 0.3.8 version of hubic"
echo "This script is not going to install nor modify anything on the configuration of your machine"
echo "its sole goal is to create a working version of hubic-browser for GNU/Linux Ubuntu 12.04"
echo "this code will become obsolete as soon as OVH decides to directly provide a working version"

rm -rf target
mkdir target
cd target
echo "Downloading hubic"
wget $HUBIC_DL
wget $libXfixes
wget $libXi
wget $libXinerama

tar xvzf hubiC-browser*.tar.gz

for theDeb in *.deb
do
  echo "Traitement de $theDeb"
  rm -rf tmp
  mkdir tmp
  cd tmp
  ar x ../$theDeb
  tar xzf data.tar.gz
  cp usr/lib/* ../hubiC-browser/.lib
  cd ..
done

tar cvzf $patchedHubiC hubiC-browser
mv $patchedHubiC ..
cd ..
rm -rf target
