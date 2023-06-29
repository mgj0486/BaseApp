//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dev team on 2023/06/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

let uiTarget = Target.createWithoutResource(
    targetName: Module.ui.name,
    product: .framework,
    infoPlist: infoPlist,
    scripts: [],
    dependencies: [
    ],
    settings: nil
)

let project = Project.create(
    name: Module.ui.name,
    packages: [
    ],
    targets: [
        uiTarget
    ],
    schemes: []
)
