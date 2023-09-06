//
//  CenteredHStack.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI

struct CenteredHStack<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder _ contentBuilder: () -> Content) {
        self.content = contentBuilder()
    }
    
    var body: some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
    
}

#Preview {
    CenteredHStack {
        Text("hello")
            .background(Color.blue)
    }
}
