//
//  AppGroup.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import Foundation

enum AppGroup: String {
    
    case facts = "group.com.ricardosm.TimeFlare"
    
    var containerURL: URL {
        switch self {
        case .facts:
            return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: self.rawValue)!
        }
    }
    
}
