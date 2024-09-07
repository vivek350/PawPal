//
//  InterestsViewModel.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

@MainActor
class InterestViewModel: ObservableObject {
    @Published var staticInterests: [String: String] = [
        "Squirrel Watching"      : "hare.fill",
        "Stick Collecting"       : "leaf.fill",
        "Hole Digging"           : "minus.circle.fill",
        "Water Bowl Splashing"   : "drop.fill",
        "Shoe Relocation"        : "shoeprints.fill",
        "Car Scenery Enjoyment"  : "car.fill",
        "Belly Rub Research"     : "hands.sparkles.fill",
        "Pillow Fort Engineering": "bed.double.fill",
        "Food Crumb Scavenging"  : "takeoutbag.and.cup.and.straw.fill",
        "Doorbell Orchestra"     : "bell.fill",
        "Zoomies"                : "bolt.fill",
        "Sock Hoarding"          : "bag.fill",
        "Sunbeam Lounging"       : "sun.max.fill",
        "Trash Can Exploration"  : "trash.fill",
        "TV Barking Commentary"  : "tv.fill",
        "Bird Chasing"           : "bird.fill"
    ]
    
    // List of selected breeds
        @Published var selectedInterests: [String] = []
        
        // Toggle selection state of a breed
        func toggleSelection(for interest: String) {
            if selectedInterests.contains(interest) {
                selectedInterests.removeAll { $0 == interest }
            } else {
                selectedInterests.append(interest)
            }
        }
        
        // Check if a breed is selected
        func isSelected(_ interest: String) -> Bool {
            return selectedInterests.contains(interest)
        }
}



