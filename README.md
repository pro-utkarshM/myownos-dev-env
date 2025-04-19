# myOwnOS Setup Script

This repository contains a setup script to help you get started with [myOwnOS](https://github.com/pro-utkarshM/myOwnOS) — a bare-metal operating system built for learning and hacking on x86 architecture.

---

## What This Script Does

This script (`setup.sh`) automates the following:

- Updates your system packages.
- Installs all required dependencies (including QEMU, NASM, build tools, etc.).
- Builds a cross-compiler toolchain (`i686-elf-gcc` and `binutils`).
- Clones the `myOwnOS` repository.
- Builds the OS and runs it using QEMU.

---
## Prerequisites

- A Debian-based Linux system (e.g., Ubuntu)
- ~4GB free disk space
- Internet connection
- `sudo` access


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

### Display & Remote Access (Optional)
- `xauth`
- `x11-apps`
- `xrdp`

### Code Analysis (Optional)
- `cloc` – to count lines of code

---

## Getting Started

1. **Download the setup script:**

   ```bash
   git clone https://github.com/pro-utkarshM/setup_myOwnOS.git
   cd setup_myOwnOS
   ```

2. **Run the script:**

   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Done!** The script will build the OS and launch it in QEMU.

---

## Customization

You can modify the toolchain versions inside the script:

```bash
BINUTILS_VERSION=2.35
GCC_VERSION=10.2.0
```

Change these values if you'd like to use different versions.

---

## Developed & Maintained By

**Utkarsh Maurya**  
[GitHub: @pro-utkarshM](https://github.com/pro-utkarshM)

---
