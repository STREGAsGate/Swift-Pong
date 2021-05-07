// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Swift-Pong",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .executable(name: "Swift-Pong", targets: ["Swift-Pong"])
    ],
    dependencies: [
        .package(name: "Raylib", url: "https://github.com/conifer-dev/raylib-swift", .branch("master"))
    ],
    targets: [
        .target(name: "Swift-Pong", dependencies: ["Raylib"]),
        .target(    
        name: "Resources",
        resources: [
            .process("bgm.wav"),
            .process("paddleHit.wav"),

            ]
    ),
    ]
)