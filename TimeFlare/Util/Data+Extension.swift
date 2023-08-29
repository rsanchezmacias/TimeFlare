//
//  Data+Extension.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import UIKit
import SwiftUI

extension Data {
    
    func toImage() -> Image? {
        guard let image = UIImage(data: self) else { return nil }
        return Image(uiImage: image)
    }
    
}
