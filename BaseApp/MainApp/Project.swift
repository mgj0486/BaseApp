import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

private let dependencies: [TargetDependency] = [
    .featureProject
]

private let mainTarget = Target.create(
    targetName: mainProjectName,
    product: .app,
    infoPlist: infoPlist,
    scripts: [],
    dependencies: dependencies,
    settings: .settings(configurations: [.debug(name: .debug),
                                         .release(name: .release)])
)


let project = Project.create(
    name: mainProjectName,
    packages: [],
    targets: [mainTarget],//[targetWithMode(mode)],
    schemes: []//[scheeWithMode(mode)],
)
