#!/bin/bash

# This bash script clones and builds the specified poppler release

# See: https://github.com/pdf2htmlEX/buildAndPackagingTools/blob/master/building/awsEC2/scripts/dobuildPoppler

# Clone and build poppler
git clone ${POPPLER_SOURCE}

cd poppler

git checkout tags/${POPPLER_RELEASE} -b poppler-local

mkdir build

cd build

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr \
  -DENABLE_XPDF_HEADERS=ON -DENABLE_LIBOPENJPEG=none ..

make


