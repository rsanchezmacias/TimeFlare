//
//  DeadlineStorage.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/31/23.
//

import SwiftData

protocol DeadlineStorageProtocol {
    
    func setup()
    
    func fetchAll() -> [Deadline]
    func insert(deadline: Deadline)
    func delete(deadline: Deadline)
}

class DeadlineStorage: DeadlineStorageProtocol {
    
    private var modelContainer: ModelContainer?
    private var modelContext: ModelContext?
    
    func setup() {
        self.modelContainer = try? ModelContainer(
            for: Deadline.self,
            migrationPlan: DeadlineSchemaMigrationPlan.self
        )
        
        if let modelContainer = modelContainer {
            modelContext = ModelContext(modelContainer)
        }
    }
    
    func insert(deadline: Deadline) {
        modelContext?.insert(deadline)
    }
    
    func delete(deadline: Deadline) {
        modelContext?.delete(deadline)
    }
    
    func fetchAll() -> [Deadline] {
        let fetchDescriptor = FetchDescriptor<Deadline>()
        
        do {
            return try modelContext?.fetch(fetchDescriptor) ?? []
        } catch {
            return []
        }
    }
    
}
