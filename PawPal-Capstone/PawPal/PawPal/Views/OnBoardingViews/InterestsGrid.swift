//
//  InterestsGrid.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

struct InterestsGrid: View {
    
    @State var navigateToBreed = false
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @EnvironmentObject var viewModel: InterestViewModel
    
    var body: some View {
        VStack {
            Text("What are you interested in the most?").font(.headline).fontWeight(.bold)
                .padding(.all, 15)
            
            LazyVGrid(columns: columns, spacing: 25) {
                ForEach(viewModel.staticInterests.keys.sorted(), id: \.self) { interest in
                    VStack {
                        ZStack {
                            if let imageName = viewModel.staticInterests[interest] {
                                Label(interest, systemImage: imageName)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 150, height: 50)
                                    .foregroundStyle(.green.gradient)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black.opacity(0.5), lineWidth: 1)
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.orange, lineWidth: viewModel.isSelected(interest) ? 4 : 0)
                                    )
                                    .onTapGesture {
                                        viewModel.toggleSelection(for: interest)
                                    }
                            }
                        }
                    }
                    
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    navigateToBreed = true
                }) {
                    Text("Done")
                }
            }
        }
        .navigationDestination(isPresented: $navigateToBreed) {
            BreedGrid()
        }
        .navigationTitle("Interests")
    }
}

#Preview {
    InterestsGrid()
}
