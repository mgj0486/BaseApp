//
//  Project.swift
//  FirstManifests
//
//  Created by dev team on 2023/06/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

let featureTarget = Target.createWithoutResource(
    targetName: Module.feature.name,
    product: .framework,
    infoPlist: infoPlist,
    scripts: [],
    dependencies: [
        .coreProject,
        .uiProject
    ],
    settings: nil,
    coreDataModels: [CoreDataModel(coreDataPath)]
)

let project = Project.create(
    name: Module.feature.name,
    packages: [
    ],
    targets: [
        featureTarget
    ],
    schemes: []
)
