# LeoPays.CDT (Contract Development Toolkit)
## Version : 0.1.0

LeoPays.CDT is a toolchain for WebAssembly (WASM) and set of tools to facilitate smart contract development for the LeoPays platform. In addition to being a general purpose WebAssembly toolchain, [LeoPays](https://github.com/leopays-core/leopays) specific optimizations are available to support building LeoPays smart contracts.  This new toolchain is built around `Clang 7`, which means that LeoPays.CDT has the most currently available optimizations and analyses from LLVM, but as the WASM target is still considered experimental, some optimizations are incomplete or not available.

## Binary Releases
LeoPays.CDT currently supports Mac OS X brew, Linux x86_64 Debian packages, and Linux x86_64 RPM packages.

**If you have previously installed LeoPays.CDT, run the `uninstall` script (it is in the directory where you cloned LeoPays.CDT) before downloading and using the binary releases.**

### Mac OS X Brew Install
```sh
brew tap leopays-core/leopays.cdt
brew install leopays.cdt
```

### Mac OS X Brew Uninstall
```sh
brew remove leopays.cdt
```

### Debian Package Install
```sh
$ wget https://github.com/leopays-core/leopays.cdt/releases/download/v0.1.0/leopays.cdt_0.1.0-1-ubuntu-18.04_amd64.deb
$ sudo apt install ./leopays.cdt_0.1.0-1-ubuntu-18.04_amd64.deb
```

### Debian Package Uninstall
```sh
sudo apt remove leopays.cdt
```

### RPM Package Install
```sh
$ wget https://github.com/leopays-core/leopays.cdt/releases/download/v0.1.0/leopays.cdt-0.1.0-1.el7.x86_64.rpm
$ sudo yum install ./leopays.cdt-0.1.0-1.el7.x86_64.rpm
```

### RPM Package Uninstall
```sh
sudo yum remove leopays.cdt
```

## Guided Installation or Building from Scratch
```sh
git clone --recursive https://github.com/leopays-core/leopays.cdt
cd leopays.cdt
mkdir build
cd build
cmake ..
make -j8
```

From here onward you can build your contracts code by simply exporting the `build` directory to your path, so you don't have to install globally (makes things cleaner).
Or you can install globally by running this command:

```sh
sudo make install
```

### Uninstall after manual installation

```sh
sudo rm -fr /usr/local/leopays.cdt
sudo rm -fr /usr/local/lib/cmake/leopays.cdt
sudo rm /usr/local/bin/leopays-*
```

## Installed Tools

* leopays-cpp
* leopays-cc
* leopays-ld
* leopays-init
* leopays-abidiff
* leopays-wasm2wast
* leopays-wast2wasm
* leopays-ranlib
* leopays-ar
* leopays-objdump
* leopays-readelf

Below tools are not installed after brew install, you get them only by building the repository and installing from scracth, [see here](#guided_installation_or_building_from_scratch)
leopays-abidiff
leopays-ranlib
leopays-ar
leopays-objdump
leopays-readelf

## License
See [LICENSE](./LICENSE) for copyright and license terms.
See [EOSIO LICENSE](./eosio.license) for copyright and license terms.
