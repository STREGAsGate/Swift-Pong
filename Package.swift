// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Pong-Survival",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .executable(name: "Pong-Survival", targets: ["Pong-Survival"])
    ],
    dependencies: [
        .package(name: "Raylib", url: "https://github.com/conifer-dev/raylib-swift", .branch("master"))
    ],
    targets: [
        .target(
            name: "Pong-Survival", 
            dependencies: ["Raylib"],
            resources: [.copy("./src/Assets")]
            )
    ]
)