#!/bin/bash
#
# Build the SuvKernel Image and device trees for redwood.
#
# Usage: ./build.sh
# Neutron Clang is taken from ~/toolchains/neutron-clang, or from $CLANG.
#

set -e

cd "$(dirname "$0")"

CLANG=${CLANG:-$HOME/toolchains/neutron-clang}
export PATH="$CLANG/bin:$PATH"

export KBUILD_BUILD_USER=suvojeet-sengupta KBUILD_BUILD_HOST=suvkernel

# The name comes from CONFIG_LOCALVERSION only, without a + for an untagged tree
export LOCALVERSION=

ARGS=(ARCH=arm64 LLVM=1 LLVM_IAS=1
      CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabi-
      KCFLAGS="-ffile-prefix-map=$PWD/= -Wno-implicit-enum-enum-cast"
      KAFLAGS=-ffile-prefix-map="$PWD"/=)

make -j"$(nproc)" O=out "${ARGS[@]}" vendor/xiaomi-qgki_defconfig
scripts/kconfig/merge_config.sh -O out -m out/.config \
    arch/arm64/configs/vendor/redwood-fragment.config \
    arch/arm64/configs/vendor/suvkernel.config
make -j"$(nproc)" O=out "${ARGS[@]}" olddefconfig

# Fail early when an option from the fragments doesn't make it in
for opt in CONFIG_SCHED_WALT=y CONFIG_KSU=y CONFIG_KSU_SUSFS=y \
           CONFIG_MACH_XIAOMI_REDWOOD=y CONFIG_EROFS_FS=y; do
    grep -q "^$opt$" out/.config || { echo "missing from the config: $opt" >&2; exit 1; }
done

make -j"$(nproc)" O=out "${ARGS[@]}" Image dtbs

echo "Image: $PWD/out/arch/arm64/boot/Image"
