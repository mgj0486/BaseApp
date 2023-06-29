//
//  Project.swift
//  FirstManifests
//
//  Created by dev team on 2023/06/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

let coreTarget = Target.createWithoutResource(
    targetName: Module.core.name,
    product: .framework,
    infoPlist: infoPlist,
    scripts: [],
    dependencies: [
        .loggerProject,
//        .external(name: "Alamofire"),
    ],
    settings: nil
)

let project = Project.create(
    name: Module.core.name,
    packages: [
    ],
    targets: [
        coreTarget
    ],
    schemes: []
)
