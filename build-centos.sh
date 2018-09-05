#!/bin/bash
## Build pdf2htmlEX for CentOS 7.x

## inspired by
##  https://github.com/Engineer365/KHMER.PW-Bash-Collection/blob/master/CentOS-7-pdf2htmlEX-from-source.sh
##  https://github.com/coolwanglu/pdf2htmlEX/issues/741

## library versions
VPOPPLER=0.57.0
VPOPPLERDATA=0.4.8
VCAIRO=1.14.2
VFONTFORGE=20170731

CWD=`pwd`
INSTALL_PREFIX=${1:-"/usr/local"}
BUILD_DIR=${2:-"${CWD}/build"}
DEST_PREFIX=${3:-"${INSTALL_PREFIX}"}

set -ex

## install necessary tools and libs
sudo yum -y install make cmake gcc gcc-c++ gnu-getopt java-1.8.0-openjdk \
	git wget zip unzip gettext patch libtool libtool-ltdl-devel \
	pixman-devel python-devel glib2-devel pango-devel libxml2-devel libtiff-devel \
	libpng-devel giflib-devel libspiro-devel freetype-devel libjpeg-turbo-devel openjpeg-devel

# make temporary build directory
mkdir -p $BUILD_DIR

# clear build directory
rm -rf $BUILD_DIR/*

## build poppler from source
cd $BUILD_DIR
wget http://poppler.freedesktop.org/poppler-${VPOPPLER}.tar.xz -O poppler-${VPOPPLER}.tar.xz
tar xf poppler-${VPOPPLER}.tar.xz
cd poppler-${VPOPPLER}

./configure --prefix=$INSTALL_PREFIX \
            --sysconfdir=/etc     \
            --disable-static      \
            --disable-gtk-test    \
            --disable-poppler-qt4 \
            --disable-poppler-qt5 \
            --enable-xpdf-headers \
            --disable-dependency-tracking
make
make install

## install poppler-data (via YUM)
sudo yum install poppler-data

## install cairo via YUM
sudo yum install fontconfig-devel cairo-devel -y

## install fontforge
cd $BUILD_DIR
#wget https://github.com/fontforge/fontforge/archive/${VFONTFORGE}.tar.gz
#tar -xzvf ${VFONTFORGE}.tar.gz
#cd fontforge-${VFONTFORGE}/
# ... from coolwanglu's fork
git clone https://github.com/coolwanglu/fontforge.git
cd fontforge
./bootstrap
./configure --prefix=$INSTALL_PREFIX \
            --without-libzmq \
            --without-x \
            --disable-python-scripting \
            --disable-python-extension
make
make install

## build pdf2htmlEX from .
export LD_LIBRARY_PATH=$INSTALL_PREFIX/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$INSTALL_PREFIX/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$INSTALL_PREFIX/include:$CPLUS_INCLUDE_PATH
export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig:/usr/lib/pkgconfig
cd $BUILD_DIR
mkdir -p pdf2htmlEX
cd pdf2htmlEX
cmake $CWD -DENABLE_SVG=ON -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX -DPDF2HTMLEX_PREFIX=$DEST_PREFIX
make
make install
