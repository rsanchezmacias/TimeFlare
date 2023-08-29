//
//  FileService.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/29/23.
//

import Foundation
import SwiftUI
import PhotosUI

class FileService {
    
    static let shared = FileService()
    
    func loadImage(from imageSelection: PhotosPickerItem?) async -> Image? {
        
        guard let data = try? await imageSelection?.loadTransferable(type: Data.self) else {
            return nil
        }
        
        guard let uiImage = UIImage(data: data) else {
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
    
    func loadImageData(from imageSelection: PhotosPickerItem?) async -> Data? {
        
        guard let data = try? await imageSelection?.loadTransferable(type: Data.self) else {
            return nil
        }
                
        return data
    }
    
}
