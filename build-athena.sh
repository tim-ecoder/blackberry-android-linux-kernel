#!/bin/bash

rm -rf out2

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 50G
ccache -o compression=true

export ARCH=arm64
export CROSS_COMPILE=/home/ubuntu/bin/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
#export CROSS_COMPILE=/data3/los20/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-

make CONFIG_BBRY=1 O=out2 CROSS_COMPILE=$CROSS_COMPILE ARCH=$ARCH mrproper

# TODO: perf?
#make CONFIG_BBRY=1 O=out2 CROSS_COMPILE=$CROSS_COMPILE ARCH=$ARCH athena-perf_defconfig
# use config extracted from device for now
cp config-from-athena out2/.config
make CONFIG_BBRY=1 O=out2 CROSS_COMPILE=$CROSS_COMPILE ARCH=$ARCH -j12 Image.gz
