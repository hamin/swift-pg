import PackageDescription

let package = Package(
    name: "swift-pg",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/BlueSocket.git", majorVersion: 0, minor: 5),
    ]
)

// let lib = Product(name: "MongoKitten", type: .Library(.Dynamic), modules: "MongoKitten")
// products.append(lib)
