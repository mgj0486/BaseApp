//
//  LoggerProtocol.swift
//  FirstManifests
//
//  Created by dev team on 2023/06/26.
//

import Foundation
import Logger

public protocol NSLoggerProtocol {
    func log(_ text: String)
}

public struct ALoggerImpl: NSLoggerProtocol {
    public func log(_ text: String) {
        NSLogger.log("🫠 "+text)
    }
    
    public init() { }
}

public struct BLoggerImpl: NSLoggerProtocol {
    public func log(_ text: String) {
        NSLogger.log("🐙 "+text)
    }
    
    public init() { }
}
