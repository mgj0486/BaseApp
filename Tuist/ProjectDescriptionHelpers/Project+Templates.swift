import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

public let mainProjectName = "MainApp"

public let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleDisplayName": "BaseApp",
    "CFBundleShortVersionString": "1.0.0",
    "CFBundleVersion": "1",
]

extension Workspace {
    public static let workspaceName = "BaseApp"
}

extension Project {
    static var organizationName: String { "mooq" }
    
    public static func create(
        name: String,
        packages: [Package],
        settings: Settings? = nil,//Settings.projectSettings,
        targets: [Target],
        schemes: [Scheme]
    ) -> Project {
        Project(
            name: name,
            organizationName: organizationName,
            options: .options(
                disableBundleAccessors: true,
                disableSynthesizedResourceAccessors: true
            ),
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}

extension Target {
    public static func create(
        targetName: String,
        product: Product,
        infoPlist: [String: InfoPlist.Value],
        scripts: [TargetScript],
        dependencies: [TargetDependency],
        settings: Settings?
    ) -> Target {
        Target(
            name: targetName,
            platform: .iOS,
            product: product,
            productName: targetName,
            bundleId: "com" + "." + Project.organizationName + "." + Workspace.workspaceName,
            deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone, .ipad]),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: nil,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings
        )
    }
    
    public static func createWithoutResource(
        targetName: String,
        product: Product,
        infoPlist: [String: InfoPlist.Value],
        scripts: [TargetScript],
        dependencies: [TargetDependency],
        settings: Settings?
    ) -> Target {
        Target(
            name: targetName,
            platform: .iOS,
            product: product,
            productName: targetName,
            bundleId: Project.organizationName + "." + Workspace.workspaceName + "." + targetName,
            deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone, .ipad]),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            entitlements: nil,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings
        )
    }
}

public extension TargetDependency {
    static let coreProject: TargetDependency = .project(
        target: Module.core.name,
        path: "../\(Module.core.name)"
    )
    static let loggerProject: TargetDependency = .project(
        target: Module.logger.name,
        path: "../\(Module.logger.name)"
    )
    static let uiProject: TargetDependency = .project(
        target: Module.ui.name,
        path: "../\(Module.ui.name)"
    )
    static let featureProject: TargetDependency = .project(
        target: Module.feature.name,
        path: "../\(Module.feature.name)"
    )
}

public enum Module: String {
    case feature, ui, core, logger
}

public extension Module {
    var name: String {
        switch self {
        case .feature:
            return "Feature"
        case .ui:
            return "UI"
        case .core:
            return "Core"
        case .logger:
            return "Logger"
        }
    }
}
