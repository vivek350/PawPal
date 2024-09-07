//
//  Profile.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

struct ProfileView: View {
    @State var user: DogViewModel
    @State var navigateToInterests = false
    let manager = CacheManager.instance
    @AppStorage("imgCount") var imagecount: Int = 0
    
    var body: some View {
        VStack {
            ImageGrid()
            List {
                Section(header: Text("Account Info").textCase(nil)) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(user.name)
                    }
                    HStack {
                        Text("Email")
                        Spacer()
                        Text(user.email)
                    }
                    
                    HStack {
                        Text("Age")
                        Spacer()
                        Text(user.age)
                    }
                    
                    HStack {
                        Text("Profession")
                        Spacer()
                        Text("Menu")
                    }
                }
                Section {
                    Text("Delete Account").foregroundStyle(.red)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    navigateToInterests = true
                }) {
                    Text("Done")
                }
            }
        }
        .navigationDestination(isPresented: $navigateToInterests) {
            InterestsGrid()
                .environmentObject(InterestViewModel())
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView(user: DogViewModel())
}
