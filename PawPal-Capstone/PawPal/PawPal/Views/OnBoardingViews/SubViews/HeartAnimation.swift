//
//  HeartAnimation.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

struct HeartAnimation: View {
    @State var measuring = false
    
    var body: some View {
        ZStack {
            Image(systemName: "pawprint.fill")
            HeartIcon()
                .stroke(style:
                            StrokeStyle(lineWidth: 8,
                                        lineCap: .round,
                                        lineJoin: .round,
                                        miterLimit: 0,
                                        dash: [150, 15],
                                        dashPhase: measuring ? -83 : 83)
                )
                .frame(width: 81, height: 81)
                .foregroundStyle(
                    .angularGradient(
                        colors: [.red, .green, .blue],
                        center: .center,
                        startAngle: .degrees(measuring ? 360 : 0),
                        endAngle: .degrees(measuring ? 720 : 360)
                    )
                )
                .hueRotation(.degrees(measuring ? 0 : 360))
                .onAppear {
                    withAnimation(.linear(duration: 2.5)
                        .repeatForever(autoreverses: false)) {
                            measuring.toggle()
                        }
                }
        }
    }
}

#Preview {
    HeartAnimation()
}
