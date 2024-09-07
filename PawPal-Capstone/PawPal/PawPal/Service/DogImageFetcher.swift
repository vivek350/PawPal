//
//  DogImageFetcher.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/7/24.
//

import Foundation
import SwiftUI

class DogImageFetcher {
    private var fetchedImagesByBreed: [String: Set<String>] = [:]
    
    private var favoriteDogs: [Dog] = []
    
    private var key = ""
    
    // Function to fetch dog images
    func fetchDogImages(for breed: String) async throws -> [UIImage] {
        if let path = Bundle.main.path(forResource: "Supporting", ofType: "plist"),
           let configDict = NSDictionary(contentsOfFile: path),
           let apiKey = configDict["apiKey"] as? String {
            key = apiKey
        }
        let urlString = "https://api.pexels.com/v1/search?query=\(breed)&per_page=10"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check for HTTP errors
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        if httpResponse.statusCode != 200 {
            let errorMessage = "HTTP Error: \(httpResponse.statusCode)"
            throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        
        let responseData = try JSONDecoder().decode(PexelsImageResponse.self, from: data)
        
        var fetchedImages: [UIImage] = []
        var usedImageUrls = Set<String>()
        
        // Include URLs of images used by favorite dogs
        for favorite in favoriteDogs where favorite.breed == breed {
            usedImageUrls.formUnion(favorite.images.compactMap { $0.accessibilityIdentifier })
        }
        
        if let existingUrls = fetchedImagesByBreed[breed] {
            usedImageUrls.formUnion(existingUrls)
        }
        
        for photo in responseData.photos {
            guard let imageUrl = URL(string: photo.src.large) else { continue }
            let urlString = imageUrl.absoluteString
            
            if usedImageUrls.contains(urlString) {
                continue
            }
            
            let (imageData, _) = try await URLSession.shared.data(from: imageUrl)
            
            if let image = UIImage(data: imageData) {
                fetchedImages.append(image)
                usedImageUrls.insert(urlString)
                
                if fetchedImages.count >= 6 {
                    break
                }
            }
        }
        
        // Update the dictionary with the new URLs
        fetchedImagesByBreed[breed] = usedImageUrls
        
        return fetchedImages
    }
    
    // Function to save a dog as a favorite. For future
    func saveDogAsFavorite(_ dog: Dog) {
        favoriteDogs.append(dog)
        
        if var existingUrls = fetchedImagesByBreed[dog.breed] {
            existingUrls.formUnion(dog.images.compactMap { $0.accessibilityIdentifier })
            fetchedImagesByBreed[dog.breed] = existingUrls
        } else {
            fetchedImagesByBreed[dog.breed] = Set(dog.images.compactMap { $0.accessibilityIdentifier })
        }
    }
}


