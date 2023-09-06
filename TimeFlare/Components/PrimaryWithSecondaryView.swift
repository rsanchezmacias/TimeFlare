//
//  PrimaryWithSecondaryView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI

struct PrimaryWithSecondaryView<Primary: View, Secondary: View>: View {
    
    let primary: Primary?
    let secondary: Secondary?
    
    var showPrimary: Bool
    
    init(
        @ViewBuilder primary: () -> Primary?,
        @ViewBuilder secondary: () -> Secondary?,
        showPrimary: Bool
    ) {
        self.primary = primary()
        self.secondary = secondary()
        self.showPrimary = showPrimary
    }
    
    var body: some View {
        if showPrimary {
            primary
        } else {
            secondary
        }
    }
    
}

#Preview {
    PrimaryWithSecondaryView(
        primary: {
            if true {
                Text("Hello")
            } else {
                Image(systemName: "test")
            }
        },
        secondary: {
            Text("Bye")
        },
        showPrimary: false
    )
}
