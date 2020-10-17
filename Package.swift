// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftyURLRouter",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "SwiftyURLRouter",
            targets: ["SwiftyURLRouter"]
        )
    ],
    targets: [
        .target(
            name: "SwiftyURLRouter",
            path: "Sources"
        ),
    ]
)


