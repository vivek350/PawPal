//
//  DogDetailView.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/7/24.
//

import SwiftUI

struct DogDetailView: View {
    @Environment(\.dismiss) var dismiss
    let dog: Dog
    
    var body: some View {
        VStack {
            HStack {
                Text(dog.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("\(dog.age)")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .foregroundStyle(.red)
                .frame(width: 50, height: 50)
                .fontWeight(.bold)
            }
            GeometryReader(content: { geometry in
                let size = geometry.size
                ScrollView(.horizontal) {
                    HStack(spacing: 5) {
                        ForEach(dog.images, id: \.self) { dog in
                            GeometryReader(content: { proxy in
                                let cardSize = proxy.size
                                let minX = min(proxy.frame(in: .scrollView).minX * 1.4, proxy.size.width * 1.4)
                                Image(uiImage: dog)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .scaleEffect(1.25)
                                    .offset(x: -minX)
                                    .frame(width: cardSize.width,height: cardSize.height)
                                    .clipShape(.rect(cornerRadius: 15))
                                    .shadow(color: .black.opacity(0.25),radius: 8,x: 5, y:10)
                            })
                            .frame(width: size.width - 60,height: size.height - 50)
                            .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                                view.scaleEffect(phase.isIdentity ? 1: 0.95)
                            }
                        }
                    }
                    .padding(.horizontal,30)
                    .scrollTargetLayout()
                    .frame(height: size.height,alignment: .top)
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
            })
            .frame(height: 450)
            .padding(.horizontal, -15)
            .padding(.top, 10)
        }
        .padding(15)
        
        Form {
            Section(header: Text("Occupation").textCase(nil)) {
                Text(dog.profession)
            }
            
            Section(header: Text("Interests").textCase(nil)) {
                Text("\(dog.interests.joined(separator: ", "))")
            }
            
            
            
            
        }
    }
}

#Preview {
    DogDetailView(dog: Dog(breed: "Aussie", images: [.aussie], name: "Quen", age: 3, distance: 2, profession: "Therapist", interests: []))
}
