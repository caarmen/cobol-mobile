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

See the example app in [examples/android/coboldemo](examples/android/coboldemo).

## iOS

Add this repository as an SPM dependency `https://github.com/caarmen/cobol-mobile`.

See [examples/ios/CobolDemo/doc/xcode-setup.md](examples/ios/CobolDemo/doc/xcode-setup.md) for some tips on building with COBOL in Xcode.

See the example app in [examples/ios/CobolDemo](examples/ios/CobolDemo).

## Kotlin multiplatform

`settings.gradle.kts`:
```kts
dependencyResolutionManagement {
    repositories {
        maven(url = "https://caarmen.github.io/cobol-mobile")
    }
}
```

`gradle/libs.versions.toml`:
```toml
[versions]
gnucobol-kmp = "0.0.4"

[libraries]
gnucobol-kmp = { group = "ca.rmen", name = "gnucobol-kmp", version.ref = "gnucobol-kmp" }
```

`shared/build.gradle.kts`:
```kotlin
implementation(libs.gnucobol.kmp)
```

See the example app in [examples/kmp/CobolMultiplatform](examples/kmp/CobolMultiplatform).


## Licensing
The artifact is licensed under the LGPLv3 license ([COPYING.LIBRARY](COPYING.LIBRARY)).

The build scripts and example app are licensed under the MIT license ([COPYING.SCRIPTS](COPYING.SCRIPTS)).
