//
//  UserViewModel.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

class DogViewModel: ObservableObject {
    @AppStorage("userName") var name: String = ""
    @AppStorage("userEmail") var email: String = ""
    @AppStorage("userAge") var age: String = ""
    
    @Published var dogs: [Dog] = []
    @Published var swipeAction: SwipeAction?
    private let dogManager = DogManager()
    
    func loadDogs(for breeds: [String]) async {
        let newDogs =  await dogManager.createDogs(for: breeds)
        DispatchQueue.main.async {
            self.dogs = newDogs
        }
    }
    
    func remove(_ dog: Dog) {
        guard let index = dogs.firstIndex(where: {$0.id == dog.id}) else {return}
        dogs.remove(at: index)
    }
    
}
