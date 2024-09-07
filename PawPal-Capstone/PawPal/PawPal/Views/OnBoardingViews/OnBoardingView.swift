//
//  OnBoarding.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

struct OnBoarding: View {
    @AppStorage("onBoarding") var onBoardingComplete: Bool = false
    @State private var animateGradient: Bool = true
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var age = ""
    @StateObject private var user = DogViewModel()
    @State var navigateToProfile = false
    
    var body: some View {
        NavigationStack {
            VStack {
                PawStack()
                Text("Paw Pal")
                    .font(.title).fontWeight(.bold).fontDesign(.rounded)
                
                HeartAnimation()
                
                Text("Let's go fetch some dates").font(.title2).fontWeight(.semibold)
                
                PawStack()
                
                Text("Let's Get Started").fontWeight(.semibold)
                
                GroupBox {
                    TextField("Name", text: $user.name)
                }
                .backgroundStyle(.ultraThinMaterial)
                .padding(.all, 10)
                
                GroupBox {
                    TextField("Email", text: $user.email)
                }
                .backgroundStyle(.ultraThinMaterial)
                .padding(.all, 10)
                
                GroupBox {
                    TextField("Age", text: $user.age)
                        .keyboardType(.numberPad)
                }
                .backgroundStyle(.ultraThinMaterial)
                .padding(.all, 10)
                
                Button(action: {
                    navigateToProfile = true
                }) {
                    HStack {
                        Image(systemName: "dog.fill")
                        Text("Create account")
                    }
                    .disabled(user.name.isEmpty)
                    .disabled(user.age.isEmpty)
                    .disabled(user.email.isEmpty)
                }
                .buttonStyle(.borderedProminent).cornerRadius(20)
                .padding()
                Spacer()
            }
            .navigationDestination(isPresented: $navigateToProfile) {
                ProfileView(user: user)
                    .navigationBarBackButtonHidden(true)
            }
            .background {
                LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .ignoresSafeArea(.all)
            }
            
        }
        
    }
}

#Preview {
    OnBoarding()
}
