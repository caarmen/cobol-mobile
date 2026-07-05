// swift-tools-version: 6.3
import PackageDescription
import Foundation

let localFrameworkRelativePath = "ios/deps/GnuCOBOL.xcframework.zip"
let localFrameworkAbsolutePath = URL(fileURLWithPath: #filePath)
    .deletingLastPathComponent()
    .appendingPathComponent(localFrameworkRelativePath)
    .path

let frameworkTarget = FileManager.default.fileExists(atPath: localFrameworkAbsolutePath) ?
    Target.binaryTarget(
        name: "GnuCOBOLCore",
        path: localFrameworkRelativePath
    ) :
    Target.binaryTarget(
        name: "GnuCOBOLCore",
        url: "https://github.com/caarmen/cobol-mobile/releases/download/v0.0.5/GnuCOBOL.xcframework.zip",
        checksum: "ced54a1141c1255a8cfe1e05092e9fc3e32919792f30ad8bed4eb5d4e308b6a9"
    )

let package = Package(
    name: "GnuCOBOL-iOS",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GnuCOBOL-iOS",
            targets: [
                "GnuCOBOLCore",
                "GnuCOBOL"
            ]
        )
    ],
    targets: [
        frameworkTarget,
        .target(
            name: "GnuCOBOL",
            dependencies:[
                .target(name: "GnuCOBOLCore")
            ],
            path: "ios/GnuCOBOL",
            sources: ["Sources"],
            swiftSettings: [.interoperabilityMode(.C)]
        ),
    ]
)
