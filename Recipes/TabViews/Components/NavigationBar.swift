//
//  NavigationBar.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import SwiftUI

struct NavigationBar: View {
    @Binding var selectedComponent: RecipeComponent
    @Namespace private var namespace
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(RecipeComponent.allCases) { component in
                    ZStack {
                        if selectedComponent == component {
                            RoundedRectangle(cornerRadius: Constant.NavigationBar.roundedRecCornerRadius)
                                .fill(.orange.opacity(Constant.NavigationBar.roundedRecFillColorOpacity))
                                .matchedGeometryEffect(id: "cate_bg", in: namespace)
                        }
                        Text(component.title)
                            .font(.headline)
                            .foregroundStyle(.black)
                    }
                    .frame(width: Constant.NavigationBar.frameWidth, height: Constant.NavigationBar.frameHeight)
                    .onTapGesture {
                        withAnimation(.smooth(duration: Constant.NavigationBar.animationDuration)) {
                            selectedComponent = component
                        }
                    }
                }
            }
            .padding(.leading)
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, Constant.NavigationBar.vPadding)
    }
}

enum RecipeComponent: String, CaseIterable, Identifiable {
    case ingredients
    case instructions
    
    var title: String {
        rawValue.capitalized
    }
    
    var id: String {
        title
    }
}
