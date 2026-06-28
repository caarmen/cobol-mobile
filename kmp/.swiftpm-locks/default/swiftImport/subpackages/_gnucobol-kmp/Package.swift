// swift-tools-version: 5.9
import PackageDescription
let package = Package(
  name: "_gnucobol-kmp",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(
      name: "_gnucobol-kmp",
      type: .none,
      targets: ["_gnucobol-kmp"]
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
      name: "_gnucobol-kmp",
      dependencies: [
        .product(
          name: "GnuCOBOL-iOS",
          package: "cobol-mobile"
        )
      ]
    )
  ]
)
