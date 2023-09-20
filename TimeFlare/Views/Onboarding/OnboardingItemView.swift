//
//  OnboardingItem.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/19/23.
//

import SwiftUI

struct OnboardingItemView: View {
    
    let image: Image
    let textView: Text
    let reversedOrder: Bool
    
    let showDivider: Bool
    
    init(image: Image, description: String, reversedOrder: Bool = false, showDivider: Bool = true) {
        self.textView = Text(description)
        self.image = image
        self.reversedOrder = reversedOrder
        self.showDivider = showDivider
    }
    
    var body: some View {
        VStack {
            HStack {
                if !reversedOrder {
                    textView
                    Spacer()
                }
                
                image
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(.rect(cornerRadius: 8))
                
                if reversedOrder {
                    Spacer()
                    textView
                }
            }
            .frame(height: 70)
            .padding([.leading, .trailing])
            
            if showDivider {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 80, height: 2)
                    .padding([.bottom], 2)
            }
        }
    }
}

#Preview {
    OnboardingItemView(image: .onboardingWidget, description: "Test")
}
