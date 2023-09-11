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
    
    static func formattedDateComponentsFrom(
        _ startingDate: Date,
        to endingDate: Date,
        components: [DateComponent],
        filterMissingComponents: Bool = false,
        removeNegativeSign: Bool = true
    ) -> [DateComponent: String] {
        var formattedDateComponents: [DateComponent: String] = [:]
        var dateComponentToValueMap: [DateComponent: Int] = [:]
        let dateComponents = Self.allDateComponentsFrom(startingDate, to: endingDate)
        
        if let seconds = dateComponents.second, components.contains(.seconds) {
            let secondsToDisplay = removeNegativeSign ? abs(seconds): seconds
            dateComponentToValueMap[.seconds] = secondsToDisplay
            formattedDateComponents[.seconds] = "\(secondsToDisplay) \(secondsToDisplay.noun(singular: "second", plural: "seconds"))"
        }
        
        if let minutes = dateComponents.minute, components.contains(.minutes) {
            let minutesToDisplay = removeNegativeSign ? abs(minutes): minutes
            dateComponentToValueMap[.minutes] = minutesToDisplay
            formattedDateComponents[.minutes] = "\(minutesToDisplay) \(minutesToDisplay.noun(singular: "minute", plural: "minutes"))"
        }
        
        if let hours = dateComponents.hour, components.contains(.hours) {
            let hoursToDisplay = removeNegativeSign ? abs(hours): hours
            dateComponentToValueMap[.hours] = hoursToDisplay
            formattedDateComponents[.hours] = "\(hoursToDisplay) \(hoursToDisplay.noun(singular: "hour", plural: "hours"))"
        }
        
        if let days = dateComponents.day, components.contains(.days) {
            let daysToDisplay = removeNegativeSign ? abs(days): days
            dateComponentToValueMap[.days] = daysToDisplay
            formattedDateComponents[.days] = "\(daysToDisplay) \(daysToDisplay.noun(singular: "day", plural: "days"))"
        }
        
        if let years = dateComponents.year, components.contains(.years) {
            let yearsToDisplay = removeNegativeSign ? abs(years): years
            dateComponentToValueMap[.years] = yearsToDisplay
            formattedDateComponents[.years] = "\(yearsToDisplay) \(yearsToDisplay.noun(singular: "year", plural: "years"))"
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
