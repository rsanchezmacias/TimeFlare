//
//  Deadline.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/26/23.
//

import Foundation
import SwiftData
import SwiftUI

typealias Deadline = DeadlineSchemaV2.Deadline

enum DeadlineSchemaV1: VersionedSchema {
    
    static var versionIdentifier: Schema.Version = Schema.Version(0, 1, 0)
    
    static var models: [any PersistentModel.Type] {
        [Deadline.self]
    }
    
    @Model
    class Deadline: Identifiable, Hashable {
        
        let id: UUID
        var title: String
        var body: String?
        var endDate: Date
        var creationDate: Date
        var imageData: Data?
        
        @Transient var image: Image? {
            return imageData?.toImage()
        }
        
        @Transient var uiImage: UIImage? {
            guard let data = imageData else { return nil }
            return UIImage(data: data)
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
        
        static func == (lhs: Deadline, rhs: Deadline) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
    }
    
}

enum DeadlineSchemaV2: VersionedSchema {
    
    static var versionIdentifier: Schema.Version = Schema.Version(0, 2, 0)
    
    static var models: [any PersistentModel.Type] {
        [Deadline.self]
    }
    
    @Model
    class Deadline: Identifiable, Hashable {
        
        let id: UUID
        var title: String
        var body: String?
        var endDate: Date
        var creationDate: Date
        var imageData: Data?
        var featured: Bool = false
        
        @Transient var image: Image? {
            return imageData?.toImage()
        }
        
        @Transient var uiImage: UIImage? {
            guard let data = imageData else { return nil }
            return UIImage(data: data)
        }
        
        init(
            title: String,
            body: String,
            endDate: Date,
            creationDate: Date,
            imageData: Data?,
            featured: Bool = false
        ) {
            self.id = UUID()
            
            self.title = title
            self.body = body
            self.endDate = endDate
            self.creationDate = creationDate
            self.imageData = imageData
            self.featured = featured
        }
        
        static func == (lhs: Deadline, rhs: Deadline) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
    }
    
}
