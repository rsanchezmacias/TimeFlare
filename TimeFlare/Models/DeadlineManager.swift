//
//  DeadlineManager.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import Foundation
import SwiftData
import SwiftUI

enum SortType: Int, CaseIterable {
    case ascendingDate
    case descendingDate
    
    var displayText: String {
        switch self {
        case .ascendingDate:
            return "Oldest date first"
        case .descendingDate:
            return "Most recent date first"
        }
    }
}

class DeadlineManager: ObservableObject {
    
    @Injected(\.deadlineStorage) var storage
    
    @Published var featuredDeadline: Deadline?
    @Published var allDeadlines: [Deadline] = []
    @Published var ongoingDeadlines: [Deadline] = []
    @Published var expiredDeadlines: [Deadline] = []
    
    @Published var sortBy: SortType = .ascendingDate
    
    init() {
        storage.setup()
    }
    
    init(container: ModelContainer) {
        let deadlineStorage = DeadlineStorage()
        Task {
            await deadlineStorage.setup(modelContainer: container)
            InjectedValues[\.deadlineStorage] = deadlineStorage
            
            await MainActor.run {
                self.refreshDeadlines()
            }
        }
    }
    
    func refreshDeadlines() {
        allDeadlines = storage.fetchAll(sortyBy: \.endDate, reverse: sortBy == .ascendingDate)
        
        featuredDeadline = allDeadlines.first(where: { deadline in
            deadline.featured
        })
        
        ongoingDeadlines = allDeadlines.filter({ deadline in
            deadline.endDate > Date.now
        })
        
        expiredDeadlines = allDeadlines.filter({ deadline in
            deadline.endDate <= Date.now
        })
    }
    
    func delete(deadlines: [Deadline]) {
        for deadline in deadlines {
            storage.delete(deadline: deadline)
        }
        refreshDeadlines()
    }
    
    func setSortPreference(sortBy: SortType) {
        self.sortBy = sortBy
        refreshDeadlines()
    }
    
    func setAsFeatured(_ newFeaturedDeadline: Deadline, featured: Bool) {
        if featured {
            for deadline in allDeadlines {
                deadline.featured = false
            }
            
            newFeaturedDeadline.featured = true
        } else {
            newFeaturedDeadline.featured = false
        }
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
        
        storage.commit()
        refreshDeadlines()
    }
    
    func deleteAll() {
        print("Deleting all deadlines for the user...w")
    }
    
    // MARK: - Private, helper functions
    
}
