//
//  MainTab.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DogStackView()
                .tabItem {Label("PawPal", systemImage: "pawprint.fill") }
                .tag(0)
            
//            Text("Matches")
//                .tabItem {Label("Matches", systemImage: "heart.fill")}
//                .tag(1)
//
//            Text("Inbox")
//                .tabItem {Label("Chat", systemImage: "message.fill")}
//                .tag(2)
            
//            Text("Profile")
//                .tabItem {Label("Profile", systemImage: "dog.fill")}
//                .tag(1)
        }
        .tint(.primary)
    }
}

#Preview {
    MainTabView()
}
