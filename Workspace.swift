//
//  Workspace.swift
//  Config
//
//  Created by Moon kyu Jung on 2023/06/27.
//


import ProjectDescription
import ProjectDescriptionHelpers

private func projectNameWith(module: Module) -> Path {
    return "\(Workspace.workspaceName)/\(module.name)"
}

let workspace = Workspace(
    name: Workspace.workspaceName,
    projects: [
        "\(Workspace.workspaceName)/\(mainProjectName)",
        projectNameWith(module: .feature),
        projectNameWith(module: .ui),
        projectNameWith(module: .core),
        projectNameWith(module: .logger)
    ]
)
