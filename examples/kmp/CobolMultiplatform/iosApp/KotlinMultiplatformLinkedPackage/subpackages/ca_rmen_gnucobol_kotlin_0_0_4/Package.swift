// swift-tools-version: 5.9
import PackageDescription
let package = Package(
  name: "ca_rmen_gnucobol_kotlin_0_0_4",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(
      name: "ca_rmen_gnucobol_kotlin_0_0_4",
      type: .none,
      targets: ["ca_rmen_gnucobol_kotlin_0_0_4"]
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
      name: "ca_rmen_gnucobol_kotlin_0_0_4",
      dependencies: [
        .product(
          name: "GnuCOBOL-iOS",
          package: "cobol-mobile"
        )
      ]
    )
  ]
)
