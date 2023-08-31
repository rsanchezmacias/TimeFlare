//
//  DefaultImageThumbnail.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/31/23.
//

import SwiftUI

struct DefaultImageThumbnail: View {
    
    var size: CGFloat
    
    var body: some View {
        Image(systemName: "photo.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .frame(width: size, height: size)
            .background(Color.gray.opacity(0.4))
            .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    DefaultImageThumbnail(size: 300)
}
