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
        name: "GnuCOBOL",
        path: localFrameworkRelativePath
    ) :
    Target.binaryTarget(
        name: "GnuCOBOL",
        url: "https://github.com/caarmen/cobol-mobile/releases/download/v0.0.3/GnuCOBOL.xcframework.zip",
        checksum: "5034a40f0a83cd9e2477c4f9720c92876710c6bc1bbc858ff6cc09c967809c80"
    )

let package = Package(
    name: "GnuCOBOL-iOS",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "GnuCOBOL-iOS", targets: ["GnuCOBOL"])
    ],
    targets: [
        frameworkTarget
    ]
)
