//
//  DeadlineManager.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import Foundation
import SwiftData
import SwiftUI

enum SortType {
    case ascendingDate
    case descendingDate
}

class DeadlineManager: ObservableObject {
    
    private let storage = InjectedValues[\.deadlineStorage]
    
    @Published var featuredDeadline: Deadline?
    @Published var allDeadlines: [Deadline] = []
    @Published var ongoingDeadlines: [Deadline] = []
    @Published var expiredDeadlines: [Deadline] = []
    
    private var sortBy: SortType = .ascendingDate
    
    init() {
        storage.setup()
    }
    
    func refreshDeadlines() {
        allDeadlines = storage.fetchAll(sortyBy: \.endDate, reverse: false)
        
        featuredDeadline = allDeadlines.first(where: { deadline in
            deadline.featured
        })
        
        ongoingDeadlines = allDeadlines.filter({ deadline in
            deadline.endDate > Date.now && deadline != featuredDeadline
        })
        
        expiredDeadlines = allDeadlines.filter({ deadline in
            deadline.endDate <= Date.now && deadline != featuredDeadline
        })
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
            if index < 0 || index >= allDeadlines.count {
                continue
            }
            
            let deadlineToDelete = allDeadlines[index]
            storage.delete(deadline: deadlineToDelete)
        }
    }
    
    func deleteAll() {
        print("Deleting all deadlines for the user...w")
    }
    
    // MARK: - Private, helper functions
    
}
