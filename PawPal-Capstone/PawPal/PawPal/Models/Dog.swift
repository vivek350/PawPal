//
//  Dog.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import Foundation
import SwiftUI

struct Dog: Identifiable, Equatable {
    let id = UUID()
    let breed: String
    let images: [UIImage]
    let name: String
    let age: Int
    let distance: Int
    let profession: String
    let interests: [String]
}

struct PexelsImageResponse: Codable {
    let photos: [Photo]
    
    struct Photo: Codable {
        let src: Src
    }
    
    struct Src: Codable {
        let large: String
    }
}



