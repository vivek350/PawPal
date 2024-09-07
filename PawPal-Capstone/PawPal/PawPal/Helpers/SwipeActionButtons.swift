//
//  SwipeActionButtons.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/7/24.
//

import SwiftUI

enum SwipeAction {
    case reject
    case like
}

struct SwipeActionButtons: View {
    
    let model: DogViewModel
    
    var body: some View {
        HStack(spacing: 30) {
            Button {
                model.swipeAction = .reject
            } label: {
                Image(systemName: "xmark")
                    .fontWeight(.heavy)
                    .foregroundStyle(.red)
                    .background {
                        Circle()
                            .fill(.white)
                            .frame(width: 48, height: 48)
                            .shadow(radius: 6)
                    }
            }
            .frame(width: 48, height: 48)
            
            Button {
                model.swipeAction = .like
            } label: {
                Image(systemName: "heart.fill")
                    .fontWeight(.heavy)
                    .foregroundStyle(.blue)
                    .background {
                        Circle()
                            .fill(.white)
                            .frame(width: 48, height: 48)
                            .shadow(radius: 6)
                    }
            }
            .frame(width: 48, height: 48)
        }
    }
}

#Preview {
    SwipeActionButtons(model: DogViewModel())
}
