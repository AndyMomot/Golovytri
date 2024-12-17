//
//  FileManagerService.swift

import Foundation

struct FileManagerService {
    private let fileManager = FileManager.default
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func saveFile(data: Data, forPath path: String) {
        do {
            let fileURL = getFileURL(forPath: path)
            try data.write(to: fileURL)
            print("Did save file to: \(fileURL.absoluteString)")
        } catch {
            print("Error saving file: \(error)")
        }
    }
    
    func getFile(forPath path: String) -> Data? {
        do {
            let fileURL = getFileURL(forPath: path)
            let isFileExists = fileManager.fileExists(atPath: fileURL.path)
            
            if isFileExists {
                let data = try Data(contentsOf: fileURL)
                return data
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    private func getFileURL(forPath path: String) -> URL {
        return documentsDirectory.appendingPathComponent("\(path).dat")
    }
    
    
    func removeFile(forPath path: String) {
        do {
            let fileURL = getFileURL(forPath: path)
            try fileManager.removeItem(at: fileURL)
            print("File removed successfully for key: \(path)")
        } catch {
            print("Error removing file: \(path)")
        }
    }
    
    func removeAllFiles() {
        let fileManager = FileManager.default
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                try fileManager.removeItem(at: fileURL)
            }
            print("All files removed successfully from \(documentsDirectory.path)")
        } catch {
            print("Error while enumerating files in \(documentsDirectory.path): \(error.localizedDescription)")
        }
    }
}

extension FileManagerService {
    enum Keys {
        case image(id: String)
        
        var path: String {
            switch self {
            case .image(let id):
                return "image\(id)"
            }
        }
    }
}
