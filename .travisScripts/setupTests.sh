#!/bin/bash

# This bash script sets up the test environment

# Test setup
pip install --user Pillow selenium sauceclient
export DISPLAY=:99.0
test/start_xvfb.sh
pushd /
python -m SimpleHTTPServer 8000 >/dev/null 2>&1 &
popd
sleep 5

