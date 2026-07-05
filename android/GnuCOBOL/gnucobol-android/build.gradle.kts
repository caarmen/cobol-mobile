plugins {
    alias(libs.plugins.android.library)
    alias(libs.plugins.vanniktech.mavenPublish)
}

android {
    namespace = "ca.rmen.gnucobol"
    compileSdk {
        version = release(37) {
            minorApiLevel = 1
        }
    }

    defaultConfig {
        minSdk = 24

        ndk {
            abiFilters += listOf("arm64-v8a", "x86_64")
        }
        externalNativeBuild {
            cmake {
                arguments += listOf("-DANDROID_STL=none")
            }
        }
    }

    buildTypes {
        release {
            optimization {
                enable = false
            }
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    externalNativeBuild {
        cmake {
            path = file("src/main/cpp/CMakeLists.txt")
            version = "3.22.1"
        }
    }
    buildFeatures {
        prefab = true
        prefabPublishing = true
        viewBinding = true
    }
    prefab {

        create("cobjni") {
            libraryName="libcobjni"
        }

        create("cob") {
            libraryName="libcob"
            headers="${System.getenv("HOME")}/.local/cobol-android-x86_64-linux-android/include"
        }

    }
}

dependencies {
}

group = "ca.rmen"
version = "0.0.5"

mavenPublishing {
    publishToMavenCentral()

    coordinates(group.toString(), "gnucobol-android", version.toString())

    pom {
        name = "gnucobol-android"
        description = "Port of GnuCOBOL to Android."
        inceptionYear = "2026"
        url = "https://github.com/caarmen/cobol-mobile"
        licenses {
            license {
                name = "GNU LESSER GENERAL PUBLIC LICENSE (LGPL) Version 3"
                url = "https://www.gnu.org/licenses/lgpl-3.0.txt"
                distribution = "repo"
            }
        }
        developers {
            developer {
                id = "calvarez"
                name = "Carmen Alvarez"
                url = "https://github.com/caarmen"
                roles = listOf("developer")
            }
        }
        scm {
            url = "https://github.com/caarmen/cobol-mobile"
            connection = "scm:git:git://github.com/caarmen/cobol-mobile.git"
            developerConnection = "scm:git:ssh://github.com/caarmen/cobol-mobile.git"
        }
    }
}