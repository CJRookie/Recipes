//
//  Styles.swift
//  Recipes
//
//  Created by CJ on 3/23/24.
//

import SwiftUI

struct GlowRoundedRect: ViewModifier {
    let height: CGFloat
    let shadowColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            Color.white
            content
        }
        .frame(height: height)
        .clipShape(.buttonBorder)
        .shadow(color: shadowColor, radius: 4)
    }
}

extension View {
    func glowRoundedRect(rectHeight: CGFloat, glowColor: Color) -> some View {
        modifier(GlowRoundedRect(height: rectHeight, shadowColor: glowColor))
    }
}
