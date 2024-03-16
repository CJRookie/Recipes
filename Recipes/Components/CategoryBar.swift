//
//  CategoryBar.swift
//  Recipes
//
//  Created by CJ on 3/5/24.
//

import SwiftUI

struct CategoryBar: View {
    @Binding var selectedItem: CategoryItem
    @Namespace private var namespace
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(CategoryItem.allCases) { item in
                    ZStack {
                        if selectedItem == item {
                            RoundedRectangle(cornerRadius: Constant.CategoryBar.roundedRecCornerRadius)
                                .fill(.orange.opacity(Constant.CategoryBar.roundedRecFillColorOpacity))
                                .matchedGeometryEffect(id: "cate_bg", in: namespace)
                        }
                        Text(item.name)
                            .font(.headline)
                            .foregroundStyle(.black)
                    }
                    .frame(width: Constant.CategoryBar.frameWidth, height: Constant.CategoryBar.frameHeight)
                    .onTapGesture {
                        withAnimation(.smooth(duration: Constant.CategoryBar.animationDuration)) {
                            selectedItem = item
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

enum CategoryItem: String, CaseIterable, Identifiable {
    case favorite
    case dessert
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
