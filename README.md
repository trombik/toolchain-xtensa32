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

## Building the package in a VM

### Requirements

* Vagrant
* VirtualBox

### `Vagrantfile`

The following `Vagrantfile` builds the package in a `virtualbox` VM.

```ruby
> cat Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "trombik/ansible-freebsd-11.1-amd64"
  config.vm.provision "shell",
    inline: "
    sudo pkg install -y git
    if [ ! -d /usr/ports ]; then
      fetch -o - https://github.com/freebsd/freebsd-ports/archive/master.tar.gz | sudo tar -C /usr -xf - -s '/^freebsd-ports-master/ports/'
    fi
    # this is optional, but makes the build faster by installing depended packages
    sudo pkg install -y flex gperf bash gsed gnugrep gawk autoconf texinfo help2man patch gmake bison libtool wget gcc6
    (cd /usr/ports/devel && sudo git clone https://github.com/trombik/toolchain-xtensa32.git)
    sudo make -C /usr/ports/devel/toolchain-xtensa32 -DPACKAGE_BUILDING
    sudo make -C /usr/ports/devel/toolchain-xtensa32 install clean
    find /usr/local/share/toolchain-xtensa32
    "
end
```

Run the VM by:

```
> vagrant up
```

Copy the package archive to _the host_ from _the guest_ by;

```
> vagrant ssh -- cat /usr/local/share/toolchain-xtensa32/toolchain-xtensa32-freebsd_amd64-2.50200.80.tar.gz > toolchain-xtensa32-freebsd_amd64-2.50200.80.tar.gz
```
