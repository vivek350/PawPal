//
//  DogDataGenerator.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/7/24.
//

import Foundation

struct DogAttributesGenerator {
    static func generateRandomDogAttributes() -> (String, Int, Int, String, [String]) {
        let names = ["Buddy", "Max", "Bella", "Luna", "Charlie", "Rocky", "Coco", "Milo", "Daisy", "Ozzy", "Newman", "Bailey", "Jax", "Archie", "Jakie", "Harley", "Cozmo", "Kramer", "George", "Elaine"]
        
        let professions = ["Barketing Specialist", "Pawfessional Snuggler", "Therapist", "Service Dog", "Pawrk Guide", "Search and Rescue", "Chew Toy Tester", "Squirrel Surveillance Officer", "Hydration Technician", "Nap-Time Coordinator", "Chief Sniffer", "Mailman Management Consultant", "Food Quality Control Inspector", "Social Media Influ-fur", "Canine Cab Driver", "Maintenance Engineer"]
        
        let dogInterests = ["Chasing balls", "Digging holes", "Chewing toys", "Playing fetch", "Running", "Sleeping", "Barking at squirrels", "Squirrel Watching", "Stick Collecting", "Hole Digging", "Shoe Relocation", "Sock Hoarding"]
        
        let name = names.randomElement() ?? "Dog"
        let age = Int.random(in: 1...15)
        let distance = Int.random(in: 1...5)
        let profession = professions.randomElement() ?? "Companion"
        let interests = Array(dogInterests.shuffled().prefix(4))
        
        return (name, age, distance, profession, interests)
    }
}
