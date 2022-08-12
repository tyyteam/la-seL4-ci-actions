#!/bin/bash
#
# Copyright 2021, Proofcraft Pty Ltd
#
# SPDX-License-Identifier: BSD-2-Clause
#

# Docker entrypoint for seL4 cparser test

set -e

echo "::group::Setting up"
export REPO_MANIFEST="master.xml"
export MANIFEST_URL="https://github.com/seL4/sel4test-manifest.git"
checkout-manifest.sh

# add Loongarch64 support
rm -rf kernel tools/seL4 projects/musllibc projects/sel4test projects/seL4_libs projects/util_libs projects/sel4runtime
git clone -b dev https://github.com/tyyteam/la-seL4.git kernel
cd tools
git clone -b dev https://github.com/tyyteam/la-seL4_tools.git seL4
cd ../projects
git clone -b dev https://github.com/tyyteam/la-musllibc.git musllibc
git clone -b dev https://github.com/tyyteam/la-sel4test.git sel4test
git clone -b dev https://github.com/tyyteam/la-seL4_libs.git seL4_libs
git clone -b dev https://github.com/tyyteam/la-util_libs.git util_libs
git clone -b dev https://github.com/tyyteam/la-sel4runtime.git sel4runtime
cd ..

fetch-branches.sh
echo "::endgroup::"

# start test
python3 /builds/build.py
