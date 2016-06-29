import PackageDescription

let package = Package(
    name: "swift-pg",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/BlueSocket.git", majorVersion: 0, minor: 3),
        .Package(url: "https://github.com/johnno1962/NSLinux.git", majorVersion: 1, minor: 1)
    ]
)

// let lib = Product(name: "MongoKitten", type: .Library(.Dynamic), modules: "MongoKitten")
// products.append(lib)