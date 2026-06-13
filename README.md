# GnuCOBOL for mobile (Android/iOS)

Port of GnuCOBOL for mobile platforms.

## Android

The gnucobol-android artifact is available on maven central:

`versions.toml`:
```toml
[versions]
gnucobol = "0.0.2"
#...
[libraries]
gnucobol = { group = "ca.rmen", name = "gnucobol-android", version.ref = "gnucobol" }
```
`build.gradle.kts`:
```
implementation(libs.gnucobol)
```

## iOS

Add this repository as an SPM dependency `https://github.com/caarmen/cobol-mobile`.


## Licensing
The artifact is licensed under the LGPLv3 license ([COPYING.LIBRARY](COPYING.LIBRARY)).

The build scripts and example app are licensed under the MIT license ([COPYING.SCRIPTS](COPYING.SCRIPTS)).
