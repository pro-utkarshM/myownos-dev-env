# myOwnOS Setup Script

This repository contains a setup script to help you get started with [myOwnOS](https://github.com/pro-utkarshM/myOwnOS) — a bare-metal operating system built for learning and hacking on x86 architecture.

---

## What This Script Does

The `setup.sh` script automates the following tasks:

- Updates your system packages.
- Installs all required dependencies (build tools, QEMU, NASM, etc.).
- Builds a cross-compiler toolchain (`i686-elf-gcc` and `binutils`).
- Clones the `myOwnOS` repository.
- Builds the OS and runs it using QEMU.

---

## Prerequisites

- A Debian-based Linux system (e.g., Ubuntu, Linux Mint, WSL)
- ~4GB free disk space
- Internet connection
- `sudo` access

---

## Installed Packages

### Essential Development Tools
- `build-essential`
- `bison`
- `flex`
- `libgmp3-dev`
- `libmpc-dev`
- `libmpfr-dev`
- `texinfo`
- `libisl-dev`

### Toolchain Dependencies
- `nasm` – assembler for x86
- `gcc`, `make`, `g++` – C/C++ build tools

### Emulation & Debugging
- `qemu`
- `qemu-system-x86`
- `qemu-system-x86_64`
- `gdb`

---

## Getting Started 
```
curl -sSf https://raw.githubusercontent.com/pro-utkarshM/myownos-dev-env/main/setup.sh | sudo bash
```

## Getting Started (build yourself)

1. **Download the setup script:**

   ```bash
   git clone https://github.com/pro-utkarshM/setup_myOwnOS.git
   cd setup_myOwnOS
   ```

2. **Run the script:**

   ```bash
   make
   ```

3. **Done!**  
   The script will automatically build `myOwnOS` and launch it in QEMU.

---

## Customization

You can easily modify the toolchain versions by editing the variables at the top of the script:

```bash
BINUTILS_VERSION=2.35
GCC_VERSION=10.2.0
```

Change these values if you'd like to use different versions of `binutils` or `gcc`.

---

## Developed & Maintained By

**Utkarsh Maurya**  
[GitHub: @pro-utkarshM](https://github.com/pro-utkarshM)

---
