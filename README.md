# homebrew-nokkvi-macos

Homebrew tap for [nokkvi-macos](https://github.com/snusxd/nokkvi-macos), the
macOS fork of the native Navidrome music client
[nokkvi](https://github.com/f-o-o-g-s/nokkvi). (Linux users should use upstream
`f-o-o-g-s/nokkvi`.)

## Install

```sh
brew tap snusxd/nokkvi-macos
brew trust snusxd/nokkvi-macos   # Homebrew 7+ loads third-party taps only once trusted
brew install --cask nokkvi-macos
```

This cask installs `Nokkvi.app` and links the `nokkvi` CLI binary. It requires
macOS 11 (Big Sur) or newer and supports both Apple Silicon and Intel Macs.

### Gatekeeper note

`Nokkvi.app` is ad-hoc signed and not notarized by Apple. During installation,
the cask's `postflight` hook removes the `com.apple.quarantine` extended
attribute from `/Applications/Nokkvi.app` so macOS Gatekeeper does not block
launching it.

## Upgrade

```sh
brew upgrade --cask snusxd/nokkvi-macos/nokkvi-macos
```

## Uninstall

To remove the app and CLI symlink:

```sh
brew uninstall --cask snusxd/nokkvi-macos/nokkvi-macos
```

To also remove application data, caches, and saved state:

```sh
brew uninstall --cask --zap snusxd/nokkvi-macos/nokkvi-macos
```

## Automatic updates

This tap follows published releases of
[snusxd/nokkvi-macos](https://github.com/snusxd/nokkvi-macos) automatically.
The app repository's Release workflow pushes cask updates when a release is
published, and this tap's [update workflow](.github/workflows/update.yml) runs
every 30 minutes (and on `workflow_dispatch` / `repository_dispatch`) as a
fallback.
