# nvimrc
Configuration files for Neovim. Works for version >=0.11.5.

## Bug fixes

- `regen100/cmake-language-server`, the release of v2.0.0 of `pygls` introduced breaking changes to its API. This causes the cmake-language-server to crash on load. To fix, implement the changes in [this pull request](https://github.com/regen100/cmake-language-server/pull/105/files). A number of PRs which correct the `gygls` break are outstanding. Modifying the `server.py` file can be avoided once one of these PRs are merged by the maintainer of `regen100/cmake-language-server`.
