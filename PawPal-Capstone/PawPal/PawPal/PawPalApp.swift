//
//  PawPalApp.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/7/24.
//

import SwiftUI

@main
struct PawPalApp: App {
    @StateObject private var intModel = InterestViewModel()
    @StateObject private var breedModel = BreedViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(intModel)
                .environmentObject(breedModel)
        }
    }
}
