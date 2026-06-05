#!/bin/bash

# build_click.sh
# A script to perform a clean configure, build, and install of the Click Modular Router.
# Place this script in the root directory of your Click source code.

# Exit immediately if any command fails
set -e

# --- Configuration ---
CLICK_ROOT_DIR=$(pwd) # Assumes you run this from the click root directory
NUM_CORES=$(nproc)    # Use all available CPU cores for compilation

# --- Build Steps ---

echo "--- 1. Cleaning previous build (make clean) ---"
make clean

echo "--- 2. Configuring build (./configure) ---"
# Use the flags that worked for enabling all elements
./configure --disable-linuxmodule --enable-all-elements

echo "--- 3. Compiling (make) ---"
# Compile using multiple cores
make -j${NUM_CORES}

echo "--- 4. Installing (sudo make install) ---"
# Install the compiled files system-wide
sudo make install