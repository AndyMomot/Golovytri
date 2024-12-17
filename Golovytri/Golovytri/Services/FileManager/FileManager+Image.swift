//
//  FileManager+Image.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import Foundation

extension FileManagerService {
    func saveImage(data: Data, for id: String) {
        DispatchQueue.main.async {
            let path = FileManagerService.Keys.image(id: id).path
            saveFile(data: data, forPath: path)
        }
    }
    
    func fetchImage(with id: String, completion: @escaping (Data?) -> Void) {
        let path = FileManagerService.Keys.image(id: id).path
        DispatchQueue.global().async {
            let imageData = getFile(forPath: path)
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}
