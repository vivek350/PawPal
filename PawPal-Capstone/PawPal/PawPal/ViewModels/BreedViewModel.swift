//
//  BreedConstants.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

@MainActor
class BreedViewModel: ObservableObject {
    
    let staticBreeds: [String: String] = [
        "Australian Shepard": "Aussie",
        "Border Collie": "BorderCollie",
        "Beagle": "Beagle",
        "Bull Dog": "BullDog",
        "Corgi": "Corgi",
        "Doberman": "Doberman",
        "German Shepard": "German",
        "Golden Retreiver": "Golden",
        "Great Dane": "GreatDane",
        "Husky": "Husky",
        "Labrador": "Lab",
        "Pitbull" : "Pit",
        "Pug": "Pug",
        "Rottweiler": "Rottweiler",
        "Sheltie": "Sheltie"
    ]
    
    // List of selected breeds
    @Published var selectedBreeds: [String] = [] {
        didSet {
            FileManagerHelper.save(selectedBreeds, to: "selectedBreeds.json")
        }
    }
    
    init() {
        if let breeds: [String] = FileManagerHelper.load(from: "selectedBreeds.json", as: [String].self) {
            self.selectedBreeds = breeds
        }
    }
        
        func toggleSelection(for breed: String) {
            if selectedBreeds.contains(breed) {
                selectedBreeds.removeAll { $0 == breed }
            } else {
                selectedBreeds.append(breed)
            }
        }
        
        func isSelected(_ breed: String) -> Bool {
            return selectedBreeds.contains(breed)
        }
}
