//
//  DateGroup.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/20/23.
//

import Foundation

enum DateComponent: CaseIterable, Hashable {
    case seconds
    case minutes
    case hours
    case days
    case years
    
    static var orderedComponents: [DateComponent] {
        return [.seconds, .minutes, .hours, .days, .years]
    }
    
    static var timerComponents: [DateComponent] {
        return [.seconds, .minutes, .hours]
    }
    
    var singularNoun: String {
        switch self {
        case .seconds:
            return "second"
        case .minutes:
            return "minute"
        case .hours:
            return "hour"
        case .days:
            return "day"
        case .years:
            return "year"
        }
    }
    
    var pluralNoun: String {
        switch self {
        case .seconds:
            return "seconds"
        case .minutes:
            return "minutes"
        case .hours:
            return "hours"
        case .days:
            return "days"
        case .years:
            return "years"
        }
    }
    
    static func getNounForDateComponent(_ component: DateComponent, value: Int) -> String {
        return value.noun(singular: component.singularNoun, plural: component.pluralNoun)
    }
}
