//
//  DashboardToolbar.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import SwiftUI
import SwiftData

struct DashboardNavigationToolbar: ToolbarContent {
    
    private let toolbarButtonSize: CGFloat = 44
    
    // URLs for settings menu
    private let privacyPolicyURL = URL(string: "https://rsanchezmacias.github.io/TimeFlare/privacy_policy.html")
    private let termsAndConditionsURL = URL(string: "https://rsanchezmacias.github.io/TimeFlare/terms_and_conditions.html")
    private let contactUsURL = URL(string: "https://www.facebook.com/timeflareapp/")
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack(spacing: 6) {
                Image.appIconTransparent
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                Text("TimeFlare")
                    .font(.system(size: 20, weight: .bold))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding([.trailing, .leading], 12)
        }
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            Menu {
                Link("Contact Us", destination: contactUsURL!)
                Link("Terms & Conditions", destination: termsAndConditionsURL!)
                Link("Privacy Policy", destination: privacyPolicyURL!)
            } label: {
                Image(systemName: "gearshape")
            }
            .squareFrame(side: toolbarButtonSize)
            .toolbarButton()
        }
    }
}

extension View {
    
    func toolbarButton() -> some View {
        self.foregroundColor(Color.charcoal)
    }
    
}

#Preview {
    return NavigationStack(root: {
        Text("PlaceHolder")
            .toolbar(content: {
                DashboardNavigationToolbar()
            })
    })
}
