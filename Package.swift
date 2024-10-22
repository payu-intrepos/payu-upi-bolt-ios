// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let VERSION_ANALYTICS_KIT: PackageDescription.Version = "4.0.0"
let VERSION_CRASH_REPORTER: PackageDescription.Version = "4.0.0"
let VERSION_NETWORK_REACHABILITY: PackageDescription.Version = "2.1.0"
let VERSION_ASSET_LIBRARY: PackageDescription.Version = "4.0.0"

let package = Package(
    name: "PayUUPIBoltUIKit",
    platforms: [
        .iOS(.v17) 
    ],
    
    products: [
        .library(
            name: "PayUIndia-UPIBoltUIKit",
            targets: ["PayUIndia-UPIBoltUIKitTarget"]
        ),
        .library(
            name: "PayUIndia-UPIBoltKit",
            targets: ["PayUIndia-UPIBoltKitTarget"]
        )
    ],
    
    dependencies: [
        .package(url: "https://github.com/payu-intrepos/PayUNetworkReachability-iOS.git", from: VERSION_NETWORK_REACHABILITY),
        .package(url: "https://github.com/payu-intrepos/PayUAnalytics-iOS.git", from: VERSION_ANALYTICS_KIT),
        .package(url: "https://github.com/payu-intrepos/PayUCrashReporter-iOS.git", from: VERSION_CRASH_REPORTER),
        .package(url: "https://github.com/payu-intrepos/PayUAssetLibrary-iOS.git", from: VERSION_ASSET_LIBRARY)
    ],
    
    targets: [
        .binaryTarget(name: "PayUUPIBoltUIKit", path: "./Frameworks/PayUUPIBoltUIKit.xcframework"),
        .binaryTarget(name: "PayUUPIBoltKit", path: "./Frameworks/PayUUPIBoltKit.xcframework"),
        .binaryTarget(name: "PayUUPIBoltBaseKit", path: "./Frameworks/PayUUPIBoltBaseKit.xcframework"),
        .target(
            name: "PayUIndia-UPIBoltUIKitTarget",
            dependencies: [
                "PayUUPIBoltUIKit",
                "PayUUPIBoltKit",
            ],
            path: "Wrappers/PayUUPIBoltUIKitWrapper"
        ),
        .target(
            name: "PayUIndia-UPIBoltKitTarget",
            dependencies: [
                "PayUUPIBoltKit",
                "PayUUPIBoltBaseKit",
                .product(name: "PayUIndia-Analytics", package: "PayUAnalytics-iOS"),
                .product(name: "PayUIndia-NetworkReachability", package: "PayUNetworkReachability-iOS"),
                .product(name: "PayUIndia-CrashReporter", package: "PayUCrashReporter-iOS"),
                .product(name: "PayUIndia-AssetLibrary", package: "PayUAssetLibrary-iOS"),
            ],
            path: "Wrappers/PayUUPIBoltKitWrapper"
        )
    ]
)
