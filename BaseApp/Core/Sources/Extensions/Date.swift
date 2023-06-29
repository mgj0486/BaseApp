//
//  Date.swift
//  AnnualDiary
//
//  Created by dev team on 2023/03/09.
//

import Foundation

public extension Date {
    func toString(_ format: String) -> String {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = format
        return formatter3.string(from: self)
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}
