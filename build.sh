#!/bin/bash
export PATH="/home/louis/android-kernel/toolchain/android-kernel-tools/linaro-gcc-4.9/arm-linux-gnueabi/bin:/home/louis/android-kernel/toolchain/android-kernel-tools/linaro-gcc-4.9/aarch64-linux-gnu/bin:/home/louis/android-kernel/toolchain/android-kernel-tools/clang-r428724/bin:$PATH"

make ARCH=arm64 LLVM=1 LLVM_IAS=1 O=out mrproper
make ARCH=arm64 LLVM=1 LLVM_IAS=1 O=out equuleus_user_defconfig
make -j16             O=out \
		      ARCH=arm64 \
		      CC=clang \
		      LLVM=1 \
                      LLVM_IAS=1 \
		      CROSS_COMPILE=aarch64-linux-gnu- \
		      CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
		      AR=llvm-ar \
		      NM=llvm-nm \
		      OBJCOPY=llvm-objcopy \
		      OBJDUMP=llvm-objdump \
		      READELF=llvm-readelf \
		      OBJSIZE=llvm-size \
		      STRIP=llvm-strip \
		      HOSTCC=clang \
		      HOSTCXX=clang++ \
		      LLVM_AR=llvm-ar \
		      LLVM_DIS=llvm-dis \
		      CONFIG_NO_ERROR_ON_MISMATCH=y 2>&1 | tee kernel.log
