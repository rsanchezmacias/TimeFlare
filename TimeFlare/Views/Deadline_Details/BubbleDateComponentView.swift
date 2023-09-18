//
//  BubbleDateComponentView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/18/23.
//

import SwiftUI

struct BubbleDateComponentView: View {
    
    let item: DateItem
    let diameter: CGFloat
    
    private var borderCircleDiameter: CGFloat {
        return diameter + 4
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.charcoal)
                .frame(width: borderCircleDiameter, height: borderCircleDiameter)
                .clipShape(.circle)
            VStack(alignment: .center, spacing: 2, content: {
                Text("\(item.value)")
                    .font(.system(size: 24))
                    .minimumScaleFactor(0.5)
                    .bold()
                    .colorInvert()
                Text(item.noun)
                    .font(.system(size: 8))
                    .minimumScaleFactor(0.8)
                    .textCase(.uppercase)
                    .fontWeight(.semibold)
                    .colorInvert()
            })
            .lineLimit(0)
            .padding()
            .frame(width: diameter, height: diameter)
            .background(Color.metal)
            .clipShape(.circle)
        }
        .shadow(radius: 2, x: 2, y: 2)
    }
    
}
