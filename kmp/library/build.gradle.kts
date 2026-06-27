import org.jetbrains.kotlin.gradle.ExperimentalKotlinGradlePluginApi
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.android.kotlin.multiplatform.library)
    alias(libs.plugins.vanniktech.mavenPublish)
}

group = "ca.rmen"
version = "0.0.4"

kotlin {
    androidLibrary {
        namespace = "ca.rmen.gnucobol.kmp"
        compileSdk = libs.versions.android.compileSdk.get().toInt()
        minSdk = libs.versions.android.minSdk.get().toInt()

        compilerOptions {
            jvmTarget = JvmTarget.JVM_11
        }
    }
    listOf(
        iosArm64(),
        iosSimulatorArm64()
    ).forEach { iosTarget ->
        iosTarget.binaries.framework {
            baseName = "Shared"
            isStatic = true
        }
        iosTarget.compilations.getByName("main") {
            cinterops {
                val gnuCobol by creating {
                    compilerOpts(
                        "-I${project.rootDir}/library/src/iosMain/cpp"
                    )
                }
            }
        }
    }

    swiftPMDependencies {
        @OptIn(ExperimentalKotlinGradlePluginApi::class)
        swiftPackage(
            url = url("https://github.com/caarmen/cobol-mobile"),
            version = revision("v0.0.3"),
            products = listOf(product(name = "GnuCOBOL-iOS")),
        )
    }

    sourceSets {
        androidMain.dependencies {
            implementation(libs.gnucobol)
        }
        commonMain.dependencies {
            //put your multiplatform dependencies here
        }

    }
}

mavenPublishing {
    publishToMavenCentral()

    coordinates(group.toString(), "gnucobol-kmp", version.toString())

    pom {
        name = "gnucobol-kmp"
        description = "GnuCOBOL port for kotlin multiplatform"
        inceptionYear = "2026"
        url = "https://github.com/caarmen/cobol-mobile"
        licenses {
            license {
                name = "LGPLv3"
                url = "https://www.gnu.org/licenses/lgpl-3.0.txt"
                distribution = "repo"
            }
        }
        developers {
            developer {
                id = "caarmen"
                name = "Carmen Alvarez"
                url = "https://github.com/caarmen"
            }
        }
        scm {
            url = "https://github.com/caarmen/cobol-mobile"
            connection = "scm:git:git://github.com/caarmen/cobol-mobile.git"
            developerConnection = "scm:git:ssh://github.com/caarmen/cobol-mobile.git"
        }
    }
}
