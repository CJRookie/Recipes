//
//  BackButton.swift
//  Recipes
//
//  Created by CJ on 3/24/24.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                Image(systemName: "arrow.backward.circle")
                    .tint(.black)
                Image(systemName: "arrow.backward.circle.fill")
                    .tint(.white)
            }
        }
        .font(.title)
    }
}
