// swift-tools-version: 5.9
import PackageDescription
let package = Package(
  name: "io_github_kotlin_library_1_0_0",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(
      name: "io_github_kotlin_library_1_0_0",
      type: .none,
      targets: ["io_github_kotlin_library_1_0_0"]
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
      name: "io_github_kotlin_library_1_0_0",
      dependencies: [
        .product(
          name: "GnuCOBOL-iOS",
          package: "cobol-mobile"
        )
      ]
    )
  ]
)
