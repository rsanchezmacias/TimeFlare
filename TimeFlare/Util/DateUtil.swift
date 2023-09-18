//
//  DateUtil.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/30/23.
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

class DateUtil {
    
    // MARK: - Date Components
    
    static func allDateComponentsFrom(_ startingDate: Date, to endingDate: Date) -> DateComponents {
        return Calendar.current.dateComponents([.year, .day, .hour, .minute, .second], from: startingDate, to: endingDate)
    }
    
    static func yearsFrom(_ startingDate: Date, to endingDate: Date) -> Int? {
        return Self.allDateComponentsFrom(startingDate, to: endingDate).year
    }
    
    static func daysFrom(_ startingDate: Date, to endingDate: Date) -> Int? {
        return Self.allDateComponentsFrom(startingDate, to: endingDate).day
    }
    
    static func hoursFrom(_ startingDate: Date, to endingDate: Date) -> Int? {
        return Self.allDateComponentsFrom(startingDate, to: endingDate).hour
    }
    
    static func minutesFrom(_ startingDate: Date, to endingDate: Date) -> Int? {
        return Self.allDateComponentsFrom(startingDate, to: endingDate).minute
    }
    
    static func secondsFrom(_ startingDate: Date, to endingDate: Date) -> Int? {
        return Self.allDateComponentsFrom(startingDate, to: endingDate).second
    }
    
    /// Return the maximum date component currrently available in a date
    static func getMaxDateComponenet(for date: Date) -> (DateComponent, Int) {
        let dateComponents = Calendar.current.dateComponents([
            .second,
            .minute,
            .hour,
            .day,
            .year
        ], from: Date.now, to: date)
        
        if let years = dateComponents.year, years != 0 {
            return (.years, years)
        } else if let days = dateComponents.day, days != 0 {
            return (.days, days)
        } else if let hours = dateComponents.hour, hours != 0 {
            return (.hours, hours)
        } else if let minutes = dateComponents.minute, minutes != 0 {
            return (.minutes, minutes)
        } else if let seconds = dateComponents.second, seconds != 0 {
            return (.seconds, seconds)
        } else {
            return (.seconds, 2)
        }
    }
    
    /// Second, minute, hour date that can be used as a countdown relative to now.
    static func getCountdownDate(for date: Date) -> Date? {
        let dateComponentsForCountdown = Calendar.current.dateComponents([
            .second,
            .minute,
            .hour,
            .day,
            .year
        ], from: Date.now, to: date)
        
        return Calendar.current.date(
            byAdding: DateComponents(
                hour: dateComponentsForCountdown.hour,
                minute: dateComponentsForCountdown.minute,
                second: dateComponentsForCountdown.second
            ),
            to: Date.now
        )
    }
    
    // MARK: - Formatting
    
    static func orderedDateComponents(
        _ startingDate: Date,
        to endingDate: Date,
        components: [DateComponent],
        filterMissingComponents: Bool = false,
        removeNegativeSign: Bool = true
    ) -> [DateComponent: Int] {
        var dateComponentToValueMap: [DateComponent: Int] = [:]
        let dateComponents = Self.allDateComponentsFrom(startingDate, to: endingDate)
        
        if let seconds = dateComponents.second, components.contains(.seconds) {
            let secondsToDisplay = removeNegativeSign ? abs(seconds): seconds
            dateComponentToValueMap[.seconds] = secondsToDisplay
        }
        
        if let minutes = dateComponents.minute, components.contains(.minutes) {
            let minutesToDisplay = removeNegativeSign ? abs(minutes): minutes
            dateComponentToValueMap[.minutes] = minutesToDisplay
        }
        
        if let hours = dateComponents.hour, components.contains(.hours) {
            let hoursToDisplay = removeNegativeSign ? abs(hours): hours
            dateComponentToValueMap[.hours] = hoursToDisplay
        }
        
        if let days = dateComponents.day, components.contains(.days) {
            let daysToDisplay = removeNegativeSign ? abs(days): days
            dateComponentToValueMap[.days] = daysToDisplay
        }
        
        if let years = dateComponents.year, components.contains(.years) {
            let yearsToDisplay = removeNegativeSign ? abs(years): years
            dateComponentToValueMap[.years] = yearsToDisplay
        }
        
        if filterMissingComponents {
            for dateComponent in DateComponent.orderedComponents.reversed() {
                if dateComponentToValueMap[dateComponent] != 0 {
                    break
                }
                
                dateComponentToValueMap[dateComponent] = nil
            }
        }
        
        return dateComponentToValueMap
    }
    
}
