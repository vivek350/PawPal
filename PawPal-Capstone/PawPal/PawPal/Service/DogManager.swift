//
//  DogManager.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/7/24.
//

import Foundation
import SwiftUI

class DogManager {
    private let imageFetcher = DogImageFetcher()
    
    // Function to create dogs
    func createDogs(for breeds: [String]) async -> [Dog] {
        var dogs: [Dog] = []
        
        for breed in breeds {
            let images = try? await imageFetcher.fetchDogImages(for: breed)
            guard let images = images else { continue }
            
            let (name, age, distance, profession, interests) = DogAttributesGenerator.generateRandomDogAttributes()
            
            let dog = Dog(breed: breed, images: images, name: name, age: age, distance: distance, profession: profession, interests: interests)
            dogs.append(dog)
        }
        
        return dogs
    }
}

