# LeoPays.CDT (Contract Development Toolkit)

## Version : 0.1.0

LeoPays.CDT is a toolchain for WebAssembly (WASM) and set of tools to facilitate smart contract development for the LeoPays platform. In addition to being a general purpose WebAssembly toolchain, [LeoPays](https://github.com/leopays-core/leopays) specific optimizations are available to support building LeoPays smart contracts.  This new toolchain is built around `Clang 7`, which means that LeoPays.CDT has the most currently available optimizations and analyses from LLVM, but as the WASM target is still considered experimental, some optimizations are incomplete or not available.

## New Introductions
As of this release two new repositories are under the suite of tools provided by **LeoPays.CDT**.  These are the [Ricardian Template Toolkit](https://github.com/eosio/ricardian-template-toolkit) and the [Ricardian Specification](https://github.com/eosio/ricardian-spec).  The **Ricardian Template Toolkit** is a set of libraries to assist smart contract developers in craftinng their Ricardian contracts.  The Ricardian specification is the working specification for the above mentioned toolkit.  Please note that both projects are **alpha** releases and are subject to change.

## Upgrading
There's been a round of breaking changes, if you are upgrading please read the [Upgrade guide from 1.2 to 1.3](./04_upgrading/1.2-to-1.3.md) and [Upgrade guide from 1.5 to 1.6](./04_upgrading/1.5-to-1.6.md).

## License
[LICENSE](../LICENSE)
[EOSIO LICENSE](../eosio.license)
