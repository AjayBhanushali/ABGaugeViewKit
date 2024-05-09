// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ABGaugeViewKit",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ABGaugeViewKit",
            targets: ["ABGaugeViewKit"]
        )
    ],
    dependencies: [
        // Define your dependencies here, if any
    ],
    targets: [
        .target(
            name: "ABGaugeViewKit",
            dependencies: [],
            path: "ABGaugeViewKit"
        )
    ]
)

