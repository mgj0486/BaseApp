//
//  Dependencies.swift
//  BaseAppManifests
//
//  Created by Moon kyu Jung on 2023/06/27.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: [
//        .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.6.4"))
    ],
    platforms: [.iOS]
)
