// swift-tools-version: 5.9
import PackageDescription
let package = Package(
  name: "_library",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(
      name: "_library",
      type: .none,
      targets: ["_library"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/caarmen/cobol-mobile",
      revision: "v0.0.3"
    )
  ],
  targets: [
    .target(
      name: "_library",
      dependencies: [
        .product(
          name: "GnuCOBOL-iOS",
          package: "cobol-mobile"
        )
      ]
    )
  ]
)
