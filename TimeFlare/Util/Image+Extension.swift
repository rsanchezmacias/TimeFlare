//
//  Image+Util.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import SwiftUI
import UIKit

extension Image {
    
    static var appIconTransparent: Image {
        return Image("logo_transparent")
    }
    
    static var onboardingAddDeadline: Image {
        return Image("onboarding_add")
    }
    
    static var onboardingAddImage: Image {
        return Image("onboarding_image")
    }
    
    static var onboardingWidget: Image {
        return Image("onboarding_widget")
    }
    
    public func deadlineThumbnail() -> some View {
        return self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(.rect(cornerRadius: 8))
    }
    
}

extension UIImage {
    
    func toData() -> Data? {
        return self.pngData()
    }
    
}
