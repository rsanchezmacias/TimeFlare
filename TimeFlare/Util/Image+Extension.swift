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
    
}

extension UIImage {
    
    func toData() -> Data? {
        return self.pngData()
    }
    
}
