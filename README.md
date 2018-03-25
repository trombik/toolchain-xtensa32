# `toolchain-xtensa32` for FreeBSD

This port builds
[a forked crosstool-NG](https://github.com/espressif/crosstool-NG) and creates
a package archive, `toolchain-xtensa32` for
[ESP32 platform.io environment](https://github.com/platformio/platform-espressif32).
[The official package repository](https://bintray.com/platformio/dl-packages/toolchain-xtensa32)
currently does not provide the package for FreeBSD. You can build your own.

## Requirements

* FreeBSD with the ports tree installed
* `git(1)` (optional)

## Installation

Clone the repository under `/usr/ports/devel`.
Or download the repository archive and extract it.

```
> cd /usr/ports/devel
# git clone https://github.com/trombik/toolchain-xtensa32
```

Build and install.

```
> cd /usr/ports/devel/toolchain-xtensa32
# make
# make install
```

The archive is installed under `/usr/local/share/toolchain-xtensa32` by
default.

Create the package directory and extract the archive. Be sure to replace
`${VERSION}` in the instruction below  with the actual version number.

```
> mkdir -p ~/.platformio/packages/toolchain-xtensa32
> tar -x -C ~/.platformio/packages/toolchain-xtensa32 \
    -f /usr/local/share/toolchain-xtensa32/toolchain-xtensa32-freebsd_amd64-${VERSION}.tar.gz
```
