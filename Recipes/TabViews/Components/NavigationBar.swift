//
//  NavigationBar.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(CategoryManager.self) private var manager
    @Binding var selectedItem: Category
    @Namespace private var namespace
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(manager.categories) { category in
                    ZStack {
                        if selectedItem == category {
                            RoundedRectangle(cornerRadius: Constant.CategoryBar.roundedRecCornerRadius)
                                .fill(.orange.opacity(Constant.CategoryBar.roundedRecFillColorOpacity))
                                .matchedGeometryEffect(id: "cate_bg", in: namespace)
                        }
                        Text(category.name)
                            .font(.headline)
                            .foregroundStyle(.black)
                    }
                    .frame(width: Constant.CategoryBar.frameWidth, height: Constant.CategoryBar.frameHeight)
                    .onTapGesture {
                        withAnimation(.smooth(duration: Constant.CategoryBar.animationDuration)) {
                            selectedItem = category
                        }
                    }
                }
            }
            .padding(.leading)
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, Constant.CategoryBar.vPadding)
    }
}
