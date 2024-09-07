//
//  ImageGrid.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/6/24.
//

import SwiftUI
import PhotosUI

struct ImageGrid: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImages: [UIImage] = []
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @State private var showPhotosPicker = false
    let manager = CacheManager.instance
    private let maxImages = 6
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(0..<6) { index in
                if index < selectedImages.count {
                    Image(uiImage: selectedImages[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }else {
                    ZStack(alignment: .bottomTrailing) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.secondarySystemBackground))
                            .frame(width: 110, height: 160)
                        
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(.red.opacity(0.7))
                            .offset(x: 4, y: 4)
                            .onTapGesture {
                                showPhotosPicker = true
                            }
                    }
                }
            }
        }
        .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItem)
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        selectedImages.append(image)
                    }
                    saveImages(selectedImages)
                }
            }
        }
        .onAppear() {
            loadSavedImages()
        }
    }
    


        private func saveImages(_ images: [UIImage]) {
            clearSavedImages()
            for (index, image) in images.enumerated() {
                saveImage(image, withName: "user_image_\(index + 1)")
            }
            loadSavedImages()
        }

        private func clearSavedImages() {
            let fileManager = FileManager.default
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

            for i in 1...maxImages {
                let fileURL = documentDirectory.appendingPathComponent("user_image_\(i).jpg")
                try? fileManager.removeItem(at: fileURL)
            }
        }

        private func loadSavedImages() {
            selectedImages = []
            for i in 1...maxImages {
                if let image = loadImage(withName: "user_image_\(i)") {
                    selectedImages.append(image)
                }
            }
        }

        private func saveImage(_ image: UIImage, withName name: String) {
            guard let data = image.jpegData(compressionQuality: 0.8) else { return }
            let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("\(name).jpg")
            
            do {
                try data.write(to: filename)
            } catch {
            }
        }

        private func loadImage(withName name: String) -> UIImage? {
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("\(name).jpg")
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                return UIImage(contentsOfFile: fileURL.path)
            } else {
                return nil
            }
        }
}

#Preview {
    ImageGrid()
}
