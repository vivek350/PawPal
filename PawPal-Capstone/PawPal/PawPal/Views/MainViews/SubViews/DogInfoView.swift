//
//  DogInfoView.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

struct DogInfoView: View {
    let dog: Dog
    @Binding var showDetail: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(dog.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("\(dog.age)")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    showDetail.toggle()
                } label: {
                    Image(systemName: "photo.on.rectangle.angled")
                        .fontWeight(.bold)
                        .imageScale(.large)
                }
            }
            
            Text("\(dog.profession) | \(dog.distance) miles away")
                .font(.subheadline)
                .lineLimit(2)
        }
        .foregroundStyle(.white)
        .padding()
        .background {
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
        }
    }
}

#Preview {
    @State var show = false
    
    return DogInfoView(dog: Dog(breed: "Aussie", images: [.aussie], name: "Quen", age: 3, distance: 2, profession: "Therapist", interests: []), showDetail: $show)
}
