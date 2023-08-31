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
    
    // MARK: - Formatting
    
    static func formattedDateComponentsFrom(
        _ startingDate: Date,
        to endingDate: Date,
        components: [DateComponent],
        filterMissingComponents: Bool = false
    ) -> [DateComponent: String] {
        var formattedDateComponents: [DateComponent: String] = [:]
        var dateComponentToValueMap: [DateComponent: Int] = [:]
        let dateComponents = Self.allDateComponentsFrom(startingDate, to: endingDate)
        
        if let seconds = dateComponents.second, components.contains(.seconds) {
            dateComponentToValueMap[.seconds] = seconds
            formattedDateComponents[.seconds] = "\(seconds) \(seconds.noun(singular: "second", plural: "seconds"))"
        }
        
        if let minutes = dateComponents.minute, components.contains(.minutes) {
            dateComponentToValueMap[.minutes] = minutes
            formattedDateComponents[.minutes] = "\(minutes) \(minutes.noun(singular: "minute", plural: "minutes"))"
        }
        
        if let hours = dateComponents.hour, components.contains(.hours) {
            dateComponentToValueMap[.hours] = hours
            formattedDateComponents[.hours] = "\(hours) \(hours.noun(singular: "hour", plural: "hours"))"
        }
        
        if let days = dateComponents.day, components.contains(.days) {
            dateComponentToValueMap[.days] = days
            formattedDateComponents[.days] = "\(days) \(days.noun(singular: "day", plural: "days"))"
        }
        
        if let years = dateComponents.year, components.contains(.years) {
            dateComponentToValueMap[.years] = years
            formattedDateComponents[.years] = "\(years) \(years.noun(singular: "year", plural: "years"))"
        }
        
        if filterMissingComponents {
            for dateComponent in DateComponent.orderedComponents.reversed() {
                if dateComponentToValueMap[dateComponent] != 0 {
                    break
                }
                
                formattedDateComponents[dateComponent] = nil
            }
        }
        
        return formattedDateComponents
    }
    
}
