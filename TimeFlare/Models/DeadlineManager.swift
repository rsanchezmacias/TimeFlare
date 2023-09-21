//
//  DeadlineManager.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import Foundation
import SwiftData
import SwiftUI
import WidgetKit

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
    
    @Injected(\.deadlineStorage) private var storage
    @Injected(\.deadlineSummaryFileService) private var fileService
    
    @UserDefaultsValue(key: .sortByPreference, defaultValue: SortType.descendingDate.rawValue)
    private var userSortPreference
    
    @Published var featuredDeadline: Deadline?
    @Published var allDeadlines: [Deadline] = []
    @Published var ongoingDeadlines: [Deadline] = []
    @Published var expiredDeadlines: [Deadline] = []
    
    @Published var sortBy: SortType = .ascendingDate
    
    init() {
        sortBy = SortType(rawValue: userSortPreference) ?? .descendingDate
        
        Task {
            await storage.setup()
            
            await MainActor.run {
                self.refreshDeadlines()
            }
        }
    }
    
    init(container: ModelContainer) {
        Task {
            let deadlineStorage = DeadlineStorage()
            
            await deadlineStorage.setup(modelContainer: container)
            InjectedValues[\.deadlineStorage] = deadlineStorage
            
            refreshDeadlines()
        }
    }
    
    func refreshDeadlines() {
        Task {
            let fetchedDeadlines = await storage.fetchAll(sortyBy: \.endDate, reverse: sortBy == .ascendingDate)
            
            await MainActor.run {
                self.allDeadlines = fetchedDeadlines
                
                featuredDeadline = allDeadlines.first(where: { deadline in
                    deadline.featured
                })
                
                ongoingDeadlines = allDeadlines.filter({ deadline in
                    deadline.endDate > Date.now
                })
                
                expiredDeadlines = allDeadlines.filter({ deadline in
                    deadline.endDate <= Date.now
                })
                
                fileService.write(summaries: ongoingDeadlines.map { $0.toSummary() })
            }
        }
    }
    
    func delete(deadlines: [Deadline]) {
        Task {
            for deadline in deadlines {
                await storage.delete(deadline: deadline)
            }
            refreshDeadlines()
        }
    }
    
    func setSortPreference(sortBy: SortType) {
        self.sortBy = sortBy
        self.userSortPreference = sortBy.rawValue
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
        Task {
            await storage.insert(deadline: deadline)
            refreshDeadlines()
        }
    }
    
    func delete(deadline: Deadline, refresh: Bool = true) {
        Task {
            await storage.delete(deadline: deadline)
            refreshDeadlines()
        }
    }
    
    func deleteDeadlineInIndexSetFromList(indexSet: IndexSet, deadlines: [Deadline]) {
        for index in indexSet {
            if index < 0 || index >= deadlines.count {
                continue
            }
            
            let deadlineToDelete = deadlines[index]
            delete(deadline: deadlineToDelete)
            break
        }
        
        refreshDeadlines()
    }
    
    func deleteAll() {
        print("Deleting all deadlines for the user...w")
    }
    
}
