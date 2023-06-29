//
//  BaseData+CoreDataProperties.swift
//  
//
//  Created by dev team on 2023/06/29.
//
//

import Foundation
import CoreData


extension BaseData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BaseData> {
        return NSFetchRequest<BaseData>(entityName: "BaseData")
    }

    @NSManaged public var tempString: String?

}
