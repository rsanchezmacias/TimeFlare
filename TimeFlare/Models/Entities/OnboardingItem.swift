//
//  OnboardingItem.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/19/23.
//

import SwiftUI

enum OnboardingItem {
    case addDeadline
    case selectImage
    case widget
    
    var image: Image {
        switch self {
        case .addDeadline:
            return .onboardingAddDeadline
        case .selectImage:
            return .onboardingAddImage
        case .widget:
            return .onboardingWidget
        }
    }
    
    var description: String {
        switch self {
        case .addDeadline:
            return "Create deadlines by clicking on the plus button in the navigation bar."
        case .selectImage:
            return "Select an image to make each deadline more unique."
        case .widget:
            return "Take a glance at any ongoing deadline by adding the TimeFlare widget to your home screen."
        }
    }
}
