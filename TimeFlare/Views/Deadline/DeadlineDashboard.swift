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
                if !deadlineManager.ongoingDeadlines.isEmpty {
                    Section {
                        ForEach(deadlineManager.ongoingDeadlines) { ongoingDeadline in
                            if !ongoingDeadline.title.isEmpty {
                                NavigationLink {
                                    DeadlineView(deadline: ongoingDeadline)
                                } label: {
                                    DeadlineRow(deadline: ongoingDeadline)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            deadlineManager.deleteDeadlineAt(indexSet: indexSet)
                        }
                    } header: {
                        HStack(alignment: .center) {
                            Label("Ongoing deadlines", systemImage: "clock")
                                .font(.headline)
                            Spacer()
                        }
                    }
                }
                
                if !deadlineManager.expiredDeadlines.isEmpty {
                    // TODO: - Refactor section into view
                    Section {
                        ForEach(deadlineManager.expiredDeadlines) { expiredDeadline in
                            if !expiredDeadline.title.isEmpty {
                                NavigationLink {
                                    DeadlineView(deadline: expiredDeadline)
                                } label: {
                                    DeadlineRow(deadline: expiredDeadline)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            deadlineManager.deleteDeadlineAt(indexSet: indexSet)
                        }
                    } header: {
                        HStack(alignment: .center) {
                            Label("Expired deadlines", systemImage: "clock.badge.checkmark")
                                .font(.headline)
                            Spacer()
                            Button {
                                // TODO: - Delete all deadlines, but first show an alert for confirmation
                            } label: {
                                Label("Delete expired deadlines", systemImage: "trash")
                                    .labelStyle(.iconOnly)
                                    .foregroundStyle(Color.red)
                            }

                        }
                    }
                }
                
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
    let manager = DeadlineManager(container: container)
    manager.refreshDeadlines()
    
    return DeadlineDashboard()
        .environmentObject(manager)
}
