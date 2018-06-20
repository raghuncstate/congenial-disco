#!/bin/bash
BUILD_PATH=`pwd`
BUILD_OPTION=RELEASE
export AARCH64_TOOLCHAIN=GCC5
export UEFI_TOOLS_DIR=${BUILD_PATH}/uefi-tools
export EDK2_DIR=${BUILD_PATH}/edk2
EDK2_OUTPUT_DIR=${EDK2_DIR}/Build/HiKey/${BUILD_OPTION}_${AARCH64_TOOLCHAIN}
# Build fastboot for Trusted Firmware-A. It's used for recovery mode.
cd ${BUILD_PATH}/atf-fastboot
CROSS_COMPILE=aarch64-linux-gnu- make PLAT=hikey DEBUG=1
CROSS_COMPILE=aarch64-linux-gnu- make PLAT=hikey
# Convert DEBUG/RELEASE to debug/release
FASTBOOT_BUILD_OPTION=$(echo ${BUILD_OPTION} | tr '[A-Z]' '[a-z]')
cd ${EDK2_DIR}
# Build UEFI & Trusted Firmware-A
#${UEFI_TOOLS_DIR}/uefi-build.sh -b ${BUILD_OPTION} -a ../arm-trusted-firmware -s ../optee_os hikey
${UEFI_TOOLS_DIR}/uefi-build.sh -b ${BUILD_OPTION} -a ../arm-trusted-firmware hikey -v
cd ${BUILD_PATH}/l-loader
ln -sf ${EDK2_OUTPUT_DIR}/FV/bl1.bin
ln -sf ${EDK2_OUTPUT_DIR}/FV/bl2.bin
#ln -sf ${BUILD_PATH}/atf-fastboot/build/hikey/${FASTBOOT_BUILD_OPTION}/bl1.bin fastboot.bin
ln -sf ${BUILD_PATH}/atf-fastboot/build/hikey/debug/bl1.bin fastboot.bin
make hikey PTABLE_LST=linux-8g
