//
//  WelcomeView.swift
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

struct WelcomeView: View {
    
    var mainAction: Thunk
    
    private let onboardingItems: [OnboardingItem] = [.addDeadline, .selectImage, .widget]
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    HStack {
                        Image.appIconTransparent
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                        Text("Welcome to TimeFlare!")
                            .font(.system(size: 18, weight: .bold))
                        Spacer()
                    }
                    
                    VStack(spacing: 8) {
                        ForEach(onboardingItems, id: \.self) { item in
                            switch item {
                            case .addDeadline:
                                OnboardingItemView(
                                    image: item.image,
                                    description: item.description
                                )
                            case .selectImage:
                                OnboardingItemView(
                                    image: item.image,
                                    description: item.description,
                                    reversedOrder: true
                                )
                            case .widget:
                                OnboardingItemView(
                                    image: item.image,
                                    description: item.description,
                                    showDivider: false
                                )
                            }
                        }
                    }
                    .minimumScaleFactor(0.8)
                    .font(.system(size: 12))
                    
                    RectangleButton(title: "Got it!", mainAction: mainAction)
                        .padding(.top, 4)
                }
                .padding()
                .frame(width: max(geometry.size.width - 64, 0))
                .background(Color.metal)
                .clipShape(.rect(cornerRadius: 16))
                .foregroundColor(Color.white)
            }
            .environment(\.colorScheme, .light)
        })
    }
    
}

#Preview {
    WelcomeView(mainAction: {})
}
