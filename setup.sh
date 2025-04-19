#!/bin/bash

set -e

# === Colors ===
GREEN="\e[32m"
RESET="\e[0m"

echo -e "${GREEN}1. Updating and installing packages...${RESET}"
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev \
  texinfo libisl-dev nasm qemu qemu-system-x86 qemu-system-x86_64 gdb xauth x11-apps \
  xrdp git snapd bless cloc

echo -e "${GREEN}2. Setting up cross-compiler environment...${RESET}"
export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

mkdir -p "$HOME/src"
cd "$HOME/src"

BINUTILS_VERSION=2.35
GCC_VERSION=10.2.0

# === Binutils ===
if [ ! -d "binutils-$BINUTILS_VERSION" ]; then
  wget https://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.gz
  tar -xzf binutils-$BINUTILS_VERSION.tar.gz
fi

mkdir -p build-binutils
cd build-binutils
../binutils-$BINUTILS_VERSION/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make -j$(nproc)
make install
cd ..

# === GCC ===
if [ ! -d "gcc-$GCC_VERSION" ]; then
  wget https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz
  tar -xzf gcc-$GCC_VERSION.tar.gz
fi

mkdir -p build-gcc
cd build-gcc
../gcc-$GCC_VERSION/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers --disable-hosted-libstdcxx
make all-gcc -j$(nproc)
make all-target-libstdc++-v3 -j$(nproc)
make install-gcc
make install-target-libgcc
make install-target-libstdc++-v3
cd

# === Confirm cross compiler ===
$HOME/opt/cross/bin/$TARGET-gcc --version

echo -e "${GREEN}3. Cloning myOwnOS and building...${RESET}"
cd "$HOME"
git clone https://github.com/pro-utkarshM/myOwnOS.git || (cd myOwnOS && git pull)
cd myOwnOS
chmod +x build.sh run_qemu.sh
./build.sh

echo -e "${GREEN}4. Running OS in QEMU...${RESET}"
./run_qemu.sh ./bin/os.bin

echo -e "${GREEN}Setup completed!${RESET}"
