//
//  SwiftUIView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import SwiftUI
import SwiftData

struct DeadlineDashboard: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var deadlines: [Deadline]
    
    @State private var editButtonVisible: Bool = false
    
    var body: some View {
        NavigationView(content: {
            
            List {
                ForEach(deadlines) { deadline in
                    if !deadline.title.isEmpty {
                        DeadlineRow(deadline: deadline)
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteDeadlineAt(indexSet: indexSet)
                })
            }
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if deadlines.isEmpty {
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
                    .offset(y: -150)
                }
            }
            .toolbar {
                DashboardToolbar(
                    addDeadlineContent: {
                        NewDeadlineForm()
                    },
                    editButtonVisible: $editButtonVisible
                )
            }
            .onChange(of: deadlines, initial: false) { oldValue, newValue in
                editButtonVisible = !deadlines.isEmpty
            }
        })
    }
    
    func deleteDeadlineAt(indexSet: IndexSet) {
        for index in indexSet {
            if index < 0 || index >= deadlines.count {
                continue
            }
            
            let deadlineToDelete = deadlines[index]
            modelContext.delete(deadlineToDelete)
        }
    }
    
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    return DeadlineDashboard()
        .modelContainer(container)
}
