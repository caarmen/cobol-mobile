// swift-tools-version: 5.9
import PackageDescription
let package = Package(
  name: "_gnucobol-kotlin",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(
      name: "_gnucobol-kotlin",
      type: .none,
      targets: ["_gnucobol-kotlin"]
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
      name: "_gnucobol-kotlin",
      dependencies: [
        .product(
          name: "GnuCOBOL-iOS",
          package: "cobol-mobile"
        )
      ]
    )
  ]
)
