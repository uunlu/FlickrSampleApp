//
//  BoxModifier.swift
//  FlickerSample
//
//  Created by Ugur Unlu on 12/5/21.
//

import SwiftUI

struct BoxModifier: ViewModifier {
    var foregroundColor: Color = Color.gray
    var padding: CGFloat = 10
    var cornerRadius: CGFloat = 15
    var lineWidth: CGFloat = 1
    var backgroundColor: Color = .white
    var strokeColor: Color = .blue
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(strokeColor, lineWidth: lineWidth))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
