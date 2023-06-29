//
//  Shape.swift
//  AnnualDiary
//
//  Created by dev team on 2023/03/31.
//

import SwiftUI

public struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
