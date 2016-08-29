import PackageDescription

let package = Package(
    name: "swift-pg",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/BlueSocket.git", majorVersion: 0, minor: 10),
        // .Package(url: "https://github.com/CryptoKitten/MD5.git", majorVersion: 0, minor: 11),
    ]
)

// let lib = Product(name: "MongoKitten", type: .Library(.Dynamic), modules: "MongoKitten")
// products.append(lib)
