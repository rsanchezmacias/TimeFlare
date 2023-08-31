//
//  DeadlineManager.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import Foundation
import SwiftData
import SwiftUI

class DeadlineManager: ObservableObject {
    
    @Published var deadlines: [Deadline] = []
    
    private let storage = InjectedValues[\.deadlineStorage]
    
    init() {
        storage.setup()
    }
    
    func refreshDeadlines() {
        deadlines = storage.fetchAll()
    }
    
    func save(deadline: Deadline) {
        storage.insert(deadline: deadline)
        refreshDeadlines()
    }
    
    func delete(deadline: Deadline) {
        storage.delete(deadline: deadline)
        refreshDeadlines()
    }
    
    func deleteDeadlineAt(indexSet: IndexSet) {
        for index in indexSet {
            if index < 0 || index >= deadlines.count {
                continue
            }
            
            let deadlineToDelete = deadlines[index]
            storage.delete(deadline: deadlineToDelete)
        }
    }
    
    func deleteAll() {
        print("Deleting all deadlines for the user...w")
    }
    
}
