//
//  CategoryCard.swift
//  Recipes
//
//  Created by CJ on 3/21/24.
//

import SwiftUI

struct CategoryCard: View {
    @Environment(ImageCenter.self) private var imageCenter
    @State private var image: UIImage?
    let category: Category
    
    var body: some View {
        ZStack {
            Image(uiImage: image ?? UIImage())
                .resizable()
                .scaledToFill()
                .scaleEffect(2)
                .opacity(0.9)
            Text(category.name)
                .font(.system(size: 22, weight: .black))
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 2)
        }
        .glowRoundedRect(rectHeight: 100, glowColor: .gray.opacity(0.8))
        .task {
            image = await imageCenter.getImage(from: category.thumb)
        }
    }
}
