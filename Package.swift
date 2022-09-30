// swift-tools-version:5.6
import PackageDescription
let package = Package(
	name: "code",
	platforms: [.macOS(.v11), .iOS(.v13)],
	products: [
		.executable(name: "code", targets: ["code"])
	],
	dependencies: [
		.package(url: "https://github.com/TokamakUI/Tokamak", from: "0.11.0")
	],
	targets: [
		.executableTarget(
			name: "code",
			dependencies: [
				.product(name: "TokamakShim", package: "Tokamak")
			])
	]
)