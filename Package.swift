// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "GnuCOBOL-iOS",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "GnuCOBOL-iOS", targets: ["GnuCOBOL"])
    ],
    targets: [
        .binaryTarget(
            name: "GnuCOBOL",
            url: "https://github.com/caarmen/cobol-mobile/releases/download/v0.0.3/GnuCOBOL.xcframework.zip",
            checksum: "2def81285c9f7c970edde7a24c070da0f6eb868f63fb93a42efd23d6a9ab9ea9"
        )
    ]
)
