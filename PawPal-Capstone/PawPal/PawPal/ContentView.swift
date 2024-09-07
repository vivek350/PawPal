//
//  ContentView.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/5/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onBoarding") var onBoardingComplete: Bool = false
    
    var body: some View {
        if onBoardingComplete {
            MainTabView()
        }else {
            OnBoarding()
        }
    }
}

#Preview {
    ContentView()
}
