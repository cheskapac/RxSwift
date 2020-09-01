// swift-tools-version:5.0

import PackageDescription

let buildTests = false

extension Target {
  static func rxCocoa() -> [Target] {
    #if os(Linux)
      return [.target(name: "RxCocoa", dependencies: ["RxSwift", "RxRelay"])]
    #else
      return [.target(name: "RxCocoa", dependencies: ["RxSwift", "RxRelay", "RxCocoaRuntime"])]
    #endif
  }

  static func rxCocoaRuntime() -> [Target] {
    #if os(Linux)
      return []
    #else
      return [.target(name: "RxCocoaRuntime", dependencies: ["RxSwift"])]
    #endif
  }
}

let package = Package(
  name: "RxSwift",
  platforms: [.iOS(.v10)],
  products: ([
    [
      .library(name: "RxSwift", type: .dynamic, targets: ["RxSwift"]),
      .library(name: "RxCocoa", type: .dynamic, targets: ["RxCocoa"]),
      .library(name: "RxRelay", type: .dynamic, targets: ["RxRelay"]),
    ]
  ] as [[Product]]).flatMap { $0 },
  targets: ([
    [
      .target(name: "RxSwift", dependencies: []),
    ], 
    Target.rxCocoa(),
    Target.rxCocoaRuntime(),
    [
      .target(name: "RxRelay", dependencies: ["RxSwift"])
    ]
  ] as [[Target]]).flatMap { $0 },
  swiftLanguageVersions: [.v5]
)
