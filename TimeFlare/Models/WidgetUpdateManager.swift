//
//  WidgetUpdateManager.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import Foundation
import WidgetKit

protocol WidgetUpdateManagerProtocol {
    
    func setAsDirty()
    func updateWidgetContentIfNeeded()
    
}

class WidgetUpdateManager: WidgetUpdateManagerProtocol {
    
    @Injected(\.deadlineStorage) private var storage
    @Injected(\.deadlineSummaryFileService) private var fileService
    
    private let widgetKind = "TimeFlareWidget"
    private var isStorageDirty = false
    
    func updateWidgetContentIfNeeded() {
        guard isStorageDirty else {
            print("[WidgetUpdateManager] No need to reset the widget timeline")
            return
        }
        
        Task { [weak self] in
            guard let self = self else { return }
            
            let deadlines = await self.storage.fetchAll(sortyBy: \.endDate, reverse: false)
            
            await MainActor.run { [weak self] in
                guard let self = self else { return }
                
                let ongoingDeadlines = deadlines.filter({ deadline in
                    deadline.endDate > Date.now
                })
                
                fileService.write(summaries: ongoingDeadlines.map { $0.toSummary() })
                
                WidgetCenter.shared.reloadTimelines(ofKind: widgetKind)
                
                self.isStorageDirty = false
            }
        }
    }
    
    func setAsDirty() {
        isStorageDirty = true
    }
    
}
