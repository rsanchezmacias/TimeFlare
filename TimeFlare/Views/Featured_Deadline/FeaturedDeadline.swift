//
//  FeaturedDeadline.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/31/23.
//

import SwiftUI

struct FeaturedDeadline: View {
    
    var deadline: Deadline
    
    var body: some View {
        
        PrimaryWithSecondaryView(
            primary: {
                deadline.image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }, secondary: {
                Rectangle()
                    .fill(Color.mikadoYellow)
            },
            showPrimary: deadline.image != nil
        )
        .opacity(deadline.image != nil ? 0.3 : 0.7)
        .frame(height: 200)
        .clipped()
        .overlay(content: {
            FeaturedDeadlineInfo(deadline: deadline)
        })
        
    }
    
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    let manager = DeadlineManager(container: container)
    return FeaturedDeadline(deadline: SampleDeadline.sampleDeadlines[0])
        .environmentObject(manager)
        .frame(height: 150)
}
