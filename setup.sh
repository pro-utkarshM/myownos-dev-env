#!/bin/bash

set -e

# === Colors ===
GREEN="\e[32m"
RESET="\e[0m"

echo -e "${GREEN}1. Updating and installing packages...${RESET}"
sudo apt update
sudo apt install -y build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo libisl-dev

# === Environment Variables ===
echo -e "${GREEN}2. Setting up cross-compiler environment...${RESET}"
export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

mkdir -p "$HOME/src"
cd "$HOME/src"

# === Binutils ===
BINUTILS_VERSION=2.35

if [ ! -d "binutils-$BINUTILS_VERSION" ]; then
  wget https://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.gz
  tar -xzf binutils-$BINUTILS_VERSION.tar.gz
fi

mkdir -p build-binutils
cd build-binutils
../binutils-$BINUTILS_VERSION/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install
cd ..

# === GCC ===
GCC_VERSION=10.2.0

if [ ! -d "gcc-$GCC_VERSION" ]; then
  wget https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz
  tar -xzf gcc-$GCC_VERSION.tar.gz
fi

mkdir -p build-gcc
cd build-gcc
../gcc-$GCC_VERSION/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc

# === Confirm cross-compiler ===
echo -e "${GREEN}3. Verifying cross-compiler installation...${RESET}"
"$PREFIX/bin/$TARGET-gcc" --version

# === Clone and Build OS ===
echo -e "${GREEN}4. Cloning myOwnOS and building...${RESET}"
cd "$HOME"
if [ ! -d "myOwnOS" ]; then
  git clone https://github.com/pro-utkarshM/myOwnOS.git
else
  cd myOwnOS && git pull && cd ..
fi

cd myOwnOS
chmod +x build.sh run_qemu.sh
./build.sh

# === Run OS ===
echo -e "${GREEN}5. Running OS in QEMU...${RESET}"
./run_qemu.sh ./bin/os.bin

echo -e "${GREEN}Setup completed successfully!${RESET}"