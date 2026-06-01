# GnuCOBOL for mobile (Android)

Port of GnuCOBOL for mobile platforms.
For now, only Android is supported.

## Android

The gnucobol-android artifact is available on maven central:

`versions.toml`:
```toml
[versions]
gnucobol = "0.0.1"
#...
[libraries]
gnucobol = { group = "ca.rmen", name = "gnucobol-android", version.ref = "gnucobol" }
```
`build.gradle.kts`:
```
implementation(libs.gnucobol) {
    artifact {
        type = "aar"
    }
}
```

The artifact is licensed under the LGPLv3 license ([COPYING.LIBRARY](COPYING.LIBRARY)).

The build scripts and example app are licensed under the MIT license ([COPYING.SCRIPTS](COPYING.SCRIPTS)).
