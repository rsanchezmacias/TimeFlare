//
//  DeadlineStorage.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/31/23.
//

import Foundation
import SwiftData

protocol DeadlineStorageProtocol {
    
    func setup()
    
    func fetchAll<T: Comparable>(sortyBy: KeyPath<Deadline, T>, reverse: Bool) -> [Deadline]
    
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
    
    func fetchAll<T: Comparable>(sortyBy: KeyPath<Deadline, T>, reverse: Bool = false) -> [Deadline] {
        let sortDescriptor = SortDescriptor<Deadline>(sortyBy, order: reverse ? .reverse : .forward)
        let fetchDescriptor = FetchDescriptor<Deadline>(sortBy: [sortDescriptor])
        
        do {
            return try modelContext?.fetch(fetchDescriptor) ?? []
        } catch {
            return []
        }
    }
    
}
