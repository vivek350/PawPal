//
//  BreedGrid.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

struct BreedGrid: View {
    @AppStorage("onBoarding") var onBoardingComplete: Bool = false
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @EnvironmentObject var viewModel: BreedViewModel
    
    var body: some View {
        VStack {
            
            Text("If you have any preferences, select from the available options.").font(.caption)
                .padding(.bottom, 20)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.staticBreeds.keys.sorted(), id: \.self) { breed in
                    VStack {
                        ZStack {
                            if let imageName = viewModel.staticBreeds[breed] {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.white, lineWidth: 3)
                                    )
                                    .shadow(radius: 5)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.orange, lineWidth: viewModel.isSelected(breed) ? 6 : 0)
                                    )
                                    .onTapGesture {
                                        viewModel.toggleSelection(for: breed)
                                    }
                            }
                            
                        }
                        
                        Text(breed.capitalized)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    onBoardingComplete = true
                }) {
                    Text("Done")
                }
            }
        }
        .navigationTitle("Preferences")
        
    }
}

#Preview {
    BreedGrid()
}
