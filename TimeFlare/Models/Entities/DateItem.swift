//
//  DateItem.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/18/23.
//

import Foundation

struct DateItem: Identifiable {
    let id: UUID
    let value: Int
    let component: DateComponent
    
    var noun: String {
        return value.noun(
            singular: component.singularNoun,
            plural: component.pluralNoun
        )
    }
    
    init(value: Int, component: DateComponent) {
        self.id = UUID()
        self.value = value
        self.component = component
    }
}
