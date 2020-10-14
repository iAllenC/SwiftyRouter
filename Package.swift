// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Router",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "Router",
            targets: ["Router"]
        )
    ],
    targets: [
        .target(
            name: "Router",
            path: "Sources"
        ),
    ]
)


