//
//  Project.swift
//  Config
//
//  Created by Moon kyu Jung on 2023/06/27.
//

import ProjectDescription
import ProjectDescriptionHelpers

let loggerTarget = Target.createWithoutResource(
    targetName: Module.logger.name,
    product: .framework,
    infoPlist: infoPlist,
    scripts: [],
    dependencies: [
    ],
    settings: nil
)

let project = Project.create(
    name: Module.logger.name,
    packages: [
    ],
    targets: [
        loggerTarget
    ],
    schemes: []
)

public enum NSLogger {
    public static func log(_ text: String) {
        print(text)
    }
}
