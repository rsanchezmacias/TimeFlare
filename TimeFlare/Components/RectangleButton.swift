//
//  RectangleButton.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/19/23.
//

import SwiftUI

struct RectangleButton: View {
    
    let title: String
    let mainAction: Thunk
    
    var body: some View {
        Button(action: {
            mainAction()
        }, label: {
            Text(title)
                .foregroundStyle(Color.white)
                .font(.system(size: 14, weight: .bold))
        })
        .padding([.top, .bottom], 8)
        .padding([.leading, .trailing], 16)
        .background(Color.forestGreen)
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    RectangleButton(title: "Test", mainAction: {})
}
