//
//  WidgetUpdateManager.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import Foundation
import WidgetKit

protocol WidgetUpdateManagerProtocol {
    
    func setAsDirtyIfNeeded(affectedDeadline: Deadline)
    func updateWidgetContentIfNeeded()
    func updateCurrentWidgetInfo()
    
}

class WidgetUpdateManager: WidgetUpdateManagerProtocol {
    
    @Injected(\.deadlineStorage) private var storage
    @Injected(\.deadlineSummaryFileService) private var fileService
    
    private let widgetKind = "TimeFlareWidget"
    private var isStorageDirty = false
    
    private var currentWidgetInfo: WidgetInfo?
    
    init() {
        updateCurrentWidgetInfo()
    }
    
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
    
    func setAsDirtyIfNeeded(affectedDeadline: Deadline) {
        guard let configuration = currentWidgetInfo?.widgetConfigurationIntent(of: TimeFlareWidgetConfigurationIntent.self) else { return }
        
        if configuration.deadline?.id == affectedDeadline.id {
            isStorageDirty = true
        }
    }
    
    func updateCurrentWidgetInfo() {
        WidgetCenter.shared.getCurrentConfigurations { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let widgetInfoList):
                self.currentWidgetInfo = widgetInfoList.first { $0.kind == self.widgetKind }
            case .failure:
                print("[WidgetUpdateManager] No widget info found for app")
            }
        }
    }
    
}
