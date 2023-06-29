//
//  Button.swift
//  AnnualDiary
//
//  Created by dev team on 2023/03/31.
//

import SwiftUI

public struct InsetButton: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .animation(.interactiveSpring(response: 0.4, dampingFraction: 1, blendDuration: 0.2), value: configuration.isPressed)
    }
}
