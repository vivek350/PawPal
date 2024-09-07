//
//  PawStack.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI

struct PawStack: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    LeftPaw()
                    LeftPaw()
                }
                HStack(spacing: 15) {
                    LeftPaw()
                    LeftPaw()
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                HStack(spacing: 15) {
                    RightPaw()
                    RightPaw()
                }
                HStack {
                    RightPaw()
                    RightPaw()
                }
            }
        }
        .padding()
    }
}

#Preview {
    PawStack()
}

struct LeftPaw: View {
    var body: some View {
        Image(systemName: "pawprint.fill")
            .resizable()
            .frame(width: 20, height: 20)
            .rotationEffect(.degrees(75))
    }
}

struct RightPaw: View {
    var body: some View {
        Image(systemName: "pawprint.fill")
            .resizable()
            .frame(width: 20, height: 20)
            .rotationEffect(.degrees(-75))
    }
}
