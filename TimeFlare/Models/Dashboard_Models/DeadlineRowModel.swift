//
//  DeadlineRowModel.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/13/23.
//

import Foundation

class DeadlineRowModel: ObservableObject {
    
    @Published var maxDateNumber: Int = 0
    @Published var maxDateNumberText: String = ""
    
    init(date: Date) {
        update(date: date)
    }
    
    func update(date: Date) {
        let maxDateComponent = DateUtil.getMaxDateComponenet(for: date)
        
        guard maxDateComponent.0 != .seconds else {
            maxDateNumber = 1
            maxDateNumberText = "minute"
            return
        }
        
        maxDateNumber = maxDateComponent.1
        
        let noun = maxDateNumber.noun(
            singular: maxDateComponent.0.singularNoun,
            plural: maxDateComponent.0.pluralNoun
        )
        
        maxDateNumberText = "\(noun) +"
    }
}
