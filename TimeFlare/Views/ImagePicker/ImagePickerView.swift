//
//  ImagePickerView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/29/23.
//

import SwiftUI

struct ImagePickerView: View {
    
    /// Pass a binding for the selected image from the picker, if any
    @Binding var selectedUIImage: UIImage?
    
    @State private var showingImagePicker: Bool = false
    
    var body: some View {
        VStack {
            if let selectedUIImage {
                Image(uiImage: selectedUIImage)
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
        .background(Color.gray.opacity(0.4))
        .clipShape(.rect(cornerRadius: 8))
        .shadow(radius: 4, x: 2, y: 2)
        .bold()
        .foregroundColor(.white)
        .sheet(isPresented: $showingImagePicker, content: {
            ImagePickerViewController(selectedImage: $selectedUIImage)
        })
        .onTapGesture {
            showingImagePicker.toggle()
        }
        
    }
    
}

#Preview {
    ImagePickerView(selectedUIImage: .constant(nil))
}
