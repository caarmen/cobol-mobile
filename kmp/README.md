# GnuCOBOL multiplatform library (Android/iOS)

This library provides a fork of GnuCOBOL for Android and iOS for use in a Kotlin multiplatform project.

This library isn't currently published on maven central.

This may be revisited if the
[maven central limits policy](https://central.sonatype.org/publish/maven-central-publishing-limits/) is adjusted
for Kotlin multiplatform projects.

## Importing the library

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


## Example

See the [CobolMultiplatform example app](../examples/kmp/CobolMultiplatform).