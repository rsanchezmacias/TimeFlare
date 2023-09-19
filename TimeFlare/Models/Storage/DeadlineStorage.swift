//
//  DeadlineStorage.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/31/23.
//

import Foundation
import SwiftData

protocol DeadlineStorageProtocol {
    
    func setup() async
    
    func fetchAll<T: Comparable>(sortyBy: KeyPath<Deadline, T>, reverse: Bool) async -> [Deadline]
    
    func insert(deadline: Deadline) async
    func delete(deadline: Deadline) async
    
    func commit() async
}

class DeadlineStorage: DeadlineStorageProtocol {
    
    @Injected(\.widgetUpdateManager) private var widgetUpdateManager
    
    private var modelContainer: ModelContainer?
    
    @MainActor
    func setup() {
        self.modelContainer = try? ModelContainer(
            for: Deadline.self,
            migrationPlan: DeadlineSchemaMigrationPlan.self
        )
    }
    
    @MainActor
    func setup(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        
        for deadline in SampleDeadline.sampleDeadlines {
            modelContainer.mainContext.insert(deadline)
        }
    }
    
    @MainActor
    func insert(deadline: Deadline) {
        modelContainer?.mainContext.insert(deadline)
    }
    
    @MainActor
    func delete(deadline: Deadline) {
        widgetUpdateManager.setAsDirtyIfNeeded(affectedDeadline: deadline)
        modelContainer?.mainContext.delete(deadline)
    }
    
    @MainActor
    func commit() {
        do {
            try modelContainer?.mainContext.save()
        } catch {
            print("[DeadlineStorage] Failed to save changes")
        }
    }
    
    @MainActor
    func fetchAll<T: Comparable>(sortyBy: KeyPath<Deadline, T>, reverse: Bool = false) -> [Deadline] {
        let sortDescriptor = SortDescriptor<Deadline>(sortyBy, order: reverse ? .reverse : .forward)
        let fetchDescriptor = FetchDescriptor<Deadline>(sortBy: [sortDescriptor])
        
        do {
            return try modelContainer?.mainContext.fetch(fetchDescriptor) ?? []
        } catch {
            return []
        }
    }
    
}
