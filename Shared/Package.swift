// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [
        .iOS(.v17),
        .tvOS(.v17),
    ],
    products: [
        .library(
            name: "Shared",
            targets: ["Shared"]),
    ],
    dependencies: [
        // Add the Firebase dependency here
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.28.0")
    ],
    targets: [
        .target(
            name: "Shared",
            dependencies: [
                // Add Firebase dependencies as needed
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk"),
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk")
            ]),
        .testTarget(
            name: "SharedTests",
            dependencies: ["Shared"]),
    ]
)
