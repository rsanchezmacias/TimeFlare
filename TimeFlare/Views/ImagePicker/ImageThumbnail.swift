//
//  ImageThumbnail.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI
import UIKit

struct ImageThumbnail: View {
    
    var image: Image?
    
    private var usesDefaultImage: Bool {
        return image == nil
    }
    
    init(uiImage: UIImage) {
        self.image = Image(uiImage: uiImage)
    }
    
    init(image: Image?) {
        self.image = image
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.4))
            PrimaryWithSecondaryView(primary: {
                image?
                    .resizable()
            }, secondary: {
                Image(systemName: "photo.fill")
                    .resizable()
            }, showPrimary: !usesDefaultImage)
            .aspectRatio(contentMode: .fit)
            .padding(usesDefaultImage ? 16 : .zero)
        }
        .clipShape(.rect(cornerRadius: 8))
    }
    
}

#Preview {
    let manager = DeadlineManager(container: SampleDeadline.sampleDeadlineContainer)
    return ImageThumbnail(image: Image(systemName: "circle"))
        .environmentObject(manager)
}
