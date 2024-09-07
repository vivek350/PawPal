//
//  FileManager.swift
//  PawPal
//
//  Created by Vivek Gollapally on 9/7/24.
//

import Foundation

struct FileManagerHelper {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func getFileURL(fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
    
    static func save<T: Codable>(_ object: T, to fileName: String) {
        let url = getFileURL(fileName: fileName)
        do {
            let data = try JSONEncoder().encode(object)
            try data.write(to: url)
        } catch {
            print("Error saving file: \(error.localizedDescription)")
        }
    }
    
    static func load<T: Codable>(from fileName: String, as type: T.Type) -> T? {
        let url = getFileURL(fileName: fileName)
        do {
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            print("Error loading file: \(error.localizedDescription)")
            return nil
        }
    }
}

