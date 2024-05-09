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
    targets: [
        .target(
            name: "ABGaugeViewKit",
            path: "ABGaugeViewKit"
        )
    ]
)

