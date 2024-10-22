// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TreeSitterWdl",
    products: [
        .library(name: "TreeSitterWdl", targets: ["TreeSitterWdl"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterWdl",
            dependencies: [],
            path: ".",
            sources: [
                "src/parser.c",
                // NOTE: if your language has an external scanner, add it here.
            ],
            resources: [
                .copy("queries")
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .testTarget(
            name: "TreeSitterWdlTests",
            dependencies: [
                "SwiftTreeSitter",
                "TreeSitterWdl",
            ],
            path: "bindings/swift/TreeSitterWdlTests"
        )
    ],
    cLanguageStandard: .c11
)
