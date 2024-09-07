//
//  CardView.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

struct CardView: View {
    @State private var xOffset: CGFloat = 0
    @State private var degrees: Double = 0
    let dog: Dog
    let model: DogViewModel
    @State private var showDetailSheet = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Image(uiImage: dog.images.first ?? .borderCollie)
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: cardHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                DogInfoView(dog: dog, showDetail: $showDetailSheet)
                    .padding(.horizontal)
            }
        }
        
        
        .fullScreenCover(isPresented: $showDetailSheet) {
            DogDetailView(dog: dog)
        }
        .onReceive(model.$swipeAction, perform: { action in
            onReceiveAction(action)
        })
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .animation(.snappy, value: xOffset)
        .gesture(
            DragGesture()
                .onChanged(onDragBegin)
                .onEnded(onDragEnd)
        )
    }
}

#Preview {
    CardView(dog: Dog(breed: "Aussie", images: [.aussie], name: "Quen", age: 3, distance: 2, profession: "Therapist", interests: []), model: DogViewModel())
}

private extension CardView {
    var swipeCutOff: CGFloat {
        (UIScreen.main.bounds.width/2) * 0.8
    }
    
    var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.45
    }
    
    func onDragBegin(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        degrees = Double(value.translation.width / 25)
    }
    
    func onDragEnd(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        if abs(width) <= abs(swipeCutOff) {
            returnToCenter()
            return
        }
        
        if width >= abs(swipeCutOff) {
            rightSwipe()
        }else {
            leftSwipe()
        }
    }
    
    func rightSwipe() {
        withAnimation {
            xOffset = 500
            degrees = 12
        } completion: {
            model.remove(dog)
        }
    }
    
    func leftSwipe() {
        withAnimation {
            xOffset = -500
            degrees = -12
        } completion: {
            model.remove(dog)
        }
    }
    
    func returnToCenter() {
        xOffset = 0
        degrees = 0
    }
    
    func onReceiveAction(_ action: SwipeAction?) {
        guard let action else { return }
        
        let topDog = model.dogs.last
        if topDog == dog {
            
            switch action {
            case .reject:
                leftSwipe()
            case .like:
                rightSwipe()
            }
        }
    }
}
