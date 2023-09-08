//
//  DeepLink.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import Foundation

enum DeepLinkAction: String {
    case show = "show-deadline"
}

struct DeepLink {
    
    static let rawScheme = "timeflareapp"
    static let scheme = "timeflareapp://"
    
    static var defaultURL: URL {
        return URL(string: "\(scheme)home")!
    }
    
    static func showURL(deadlineId: UUID) -> URL {
        return URL(string: "\(Self.scheme)\(DeepLinkAction.show.rawValue)?id=\(deadlineId)")!
    }
    
}
