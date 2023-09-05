//
//  EmptyDeadlinesView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/1/23.
//

import SwiftUI

struct EmptyDeadlinesView: View {
    var body: some View {
        VStack(alignment: .center, content: {
            HStack(content: {
                Image(systemName: "questionmark.circle")
                Text("There are no deadlines to see...")
            })
            .padding()
            .font(.headline)
            
            Text("Click on \"Add\" to get started and see countdowns for any upcoming deadlines!")
            .multilineTextAlignment(.center)
            .padding(.bottom, 32)
        })
        .padding()
        .frame(height: 175)
        .background(Color.gray.opacity(0.40))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    let manager = DeadlineManager(container: container)
    return EmptyDeadlinesView()
        .environmentObject(manager)
}
