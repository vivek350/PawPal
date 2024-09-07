//
//  DogStackView.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

struct DogStackView: View {
    
    @EnvironmentObject var breeds: BreedViewModel
    @StateObject private var viewModel = DogViewModel()
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack {
                ForEach(viewModel.dogs) { dog in
                    CardView(dog: dog, model: viewModel)
                }
            }
            if !viewModel.dogs.isEmpty {
                SwipeActionButtons(model: viewModel)
            }
            if viewModel.dogs.isEmpty {
                ProgressView()
            }
        }
        .onAppear() {
            Task {
                await viewModel.loadDogs(for: breeds.selectedBreeds)
            }
        }
    }
}

#Preview {
    DogStackView()
}
