//
//  Array.swift
//  AnnualDiary
//
//  Created by dev team on 2023/04/04.
//

import Foundation

public extension Array {
    subscript (safe index: Int) -> Element? {
        // iOS 9 or later
        return indices ~= index ? self[index] : nil
        // iOS 8 or earlier
        // return startIndex <= index && index < endIndex ? self[index] : nil
        // return 0 <= index && index < self.count ? self[index] : nil
    }
    
    subscript(safe range: Range<Index>) -> ArraySlice<Element>? {
        if range.endIndex > endIndex {
            if range.startIndex >= endIndex { return nil }
            else { return self[range.startIndex..<endIndex] }
        }
        else {
            return self[range]
        }
    }
}
