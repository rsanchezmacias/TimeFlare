//
//  Deadline.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/26/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Deadline {
    
    let id: UUID
    var title: String
    var body: String?
    var endDate: Date
    var creationDate: Date
    var imageData: Data?
    
    @Transient var image: Image? {
        return imageData?.toImage()
    }
    
    init(
        title: String,
        body: String,
        endDate: Date,
        creationDate: Date,
        imageData: Data?
    ) {
        self.id = UUID()
        
        self.title = title
        self.body = body
        self.endDate = endDate
        self.creationDate = creationDate
        self.imageData = imageData
    }
    
}

extension Deadline: Identifiable { }

extension Deadline: Hashable {
    
    static func == (lhs: Deadline, rhs: Deadline) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
