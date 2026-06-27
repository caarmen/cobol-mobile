// swift-tools-version: 5.9
import PackageDescription
let package = Package(
  name: "_shared",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(
      name: "_shared",
      type: .none,
      targets: ["_shared"]
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
      name: "_shared",
      dependencies: [
        .product(
          name: "GnuCOBOL-iOS",
          package: "cobol-mobile"
        )
      ]
    )
  ]
)
