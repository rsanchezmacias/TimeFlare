//
//  NonEditingImagePickerView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/29/23.
//

import SwiftUI
import PhotosUI

struct NonEditingImagePickerView: View {
    
    @State var imageSelection: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        PhotosPicker(
            selection: $imageSelection,
            matching: .images,
            photoLibrary: .shared()
        ) {
            VStack {
                if let selectedImage {
                    selectedImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Image(systemName: "photo.badge.plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    Text("Add Image")
                }
            }
            .frame(width: 300, height: 300)
            .padding()
            .background(Color.gray.opacity(0.4))
            .clipShape(.rect(cornerRadius: 8))
            .shadow(radius: 4, x: 2, y: 2)
            .bold()
            .foregroundColor(.white)
        }
        .onChange(of: imageSelection, initial: false) {
            setImageAfterSelection()
        }
    }
    
    private func setImageAfterSelection() {
        guard let photoPickerItem = imageSelection else {
            return
        }
        
        Task {
            selectedImage = await FileService.shared.loadImage(from: photoPickerItem)
        }
    }
    
}

#Preview {
    NonEditingImagePickerView()
}
