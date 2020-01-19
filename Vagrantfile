require "json"
require "shellwords"

vagrant_box_name = "trombik/ansible-freebsd-11.3-amd64"
ports_prefix = "/opt"
ports_url = "https://github.com/freebsd/freebsd-ports/archive/master.tar.gz"
port_name = "devel/xtensa-esp32-elf"
port_repository = "https://github.com/trombik/xtensa-esp32-elf"
port_branch = "prefix-safe"

# XXX use "make -VRUN_DEPENDS -VBUILD_DEPENDS -VLIB_DEPENDS" instead
port_depends = %w[
  flex gperf bash gsed gnugrep gawk autoconf texinfo help2man patch gmake
  bison libtool wget gcc9 autoconf automake
]

# set USE_PACKAGE_DEPENDS_ONLY so that packages can be used during the build.
# this can fail when any of port_depends is missing for whatever reason
make_flags = "-DBATCH -DPACKAGE_BUILDING -DUSE_PACKAGE_DEPENDS_ONLY"
make_install_flags = "#{make_flags} PREFIX=#{ports_prefix}"

package_version = "2.50200.80"
package = {
  :description => "xtensa-gcc",
  :name => "toolchain-xtensa32",
  :system => "freebsd_amd64",
  :url => "https://github.com/trombik/toolchain-xtensa32",
  :version => package_version
}
package_json = JSON.generate(package)

Vagrant.configure("2") do |config|
  config.vm.box = vagrant_box_name
  config.vm.provision "shell",
    inline: "
    sudo pkg install -y git
    if [ ! -d /usr/ports ]; then
      fetch -o - #{ports_url} | sudo tar -C /usr -xf - -s '/^freebsd-ports-master/ports/'
    fi
    sudo pkg install -y #{port_depends.join(' ')}
    if [ ! -d #{port_name}/.git ]; then
      git clone --branch #{port_branch} #{port_repository} #{port_name}
    fi
    (cd #{port_name} && git pull)
    if [ ! -d /usr/ports/#{port_name}/.git ]; then
      sudo rm -rf /usr/ports/#{port_name}
      sudo cp -a #{port_name} /usr/ports/#{port_name.split('/').first}
    fi

    sudo mkdir -p /usr/ports/packages
    sudo mkdir -p #{ports_prefix}
    echo sudo make -C /usr/ports/#{port_name} #{make_flags} package PREFIX=#{ports_prefix}
    echo sudo make -C /usr/ports/#{port_name} #{make_flags} install PREFIX=#{ports_prefix}
    echo #{Shellwords.escape(package_json)} | sudo tee #{ports_prefix}/xtensa-esp32-elf/package.json
    tar -C #{ports_prefix} -czf toolchain-xtensa32-freebsd_amd64-#{package_version}.tar.gz xtensa-esp32-elf
    "
end
