# `toolchain-xtensa32` for FreeBSD

This project builds `toolchain-xtensa32` for FreeBSD in a `VirtualBox` instance.

## Notes

The FreeBSD port is not the official port of the `devel/xtensa-esp32-elf`, but
my experimental port, which can be found at:

https://github.com/trombik/xtensa-esp32-elf

## Requirements

* `VirtualBox`
* `Vagrant`

## Installation

Clone the repository.

```
> git clone https://github.com/trombik/toolchain-xtensa32
```

## Building

Spin the instance.

```
> vagrant up
```

## Installing the package to your `.platformio` directory

Copy the package archive to _the host_ from _the guest_ by;

```
> vagrant ssh -- cat toolchain-xtensa32-freebsd_amd64-2.50200.80.tar.gz > toolchain-xtensa32-freebsd_amd64-2.50200.80.tar.gz
```

Extract the archive:

```
tar -C ~/.platformio/packages -xf toolchain-xtensa32-freebsd_amd64-2.50200.80.tar.gz
```
