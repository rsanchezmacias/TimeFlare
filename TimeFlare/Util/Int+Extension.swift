//
//  Int+Extension.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/30/23.
//

import Foundation

extension Int {
    
    func noun(singular: String, plural: String) -> String {
        return self == 1 ? singular : plural
    }
    
}
