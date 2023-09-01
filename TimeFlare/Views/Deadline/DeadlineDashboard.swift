//
//  SwiftUIView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import SwiftUI
import SwiftData

struct DeadlineDashboard: View {
    
    @EnvironmentObject private var deadlineManager: DeadlineManager
    
    @State private var editButtonVisible: Bool = false
    
    var body: some View {
        NavigationView(content: {
            
            List {
                ForEach(deadlineManager.allDeadlines) { deadline in
                    if !deadline.title.isEmpty {
                        NavigationLink {
                            DeadlineView(deadline: deadline)
                        } label: {
                            DeadlineRow(deadline: deadline)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    deadlineManager.deleteDeadlineAt(indexSet: indexSet)
                })
            }
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if deadlineManager.allDeadlines.isEmpty {
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
            .onChange(of: deadlineManager.allDeadlines, initial: false) { _, _ in
                editButtonVisible = !deadlineManager.allDeadlines.isEmpty
            }
            .onAppear {
                deadlineManager.refreshDeadlines()
            }
        })
        
    }
    
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    return DeadlineDashboard()
        .modelContainer(container)
}
