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
    @State private var showConfirmationForDeletingOldDeadlines: Bool = false
    
    var body: some View {
        NavigationView(content: {
            
            List {
                // TODO: - Clean up featured deadline, not happy with current implementation
                if let featured = deadlineManager.featuredDeadline {
                    
                    FeaturedDeadline(deadline: featured)
                    .frame(height: 200)
                    .listRowInsets(EdgeInsets())
                    .overlay {
                        NavigationLink {
                            DeadlineView(deadline: featured)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0)   
                    }
                }
                
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
                            .font(.system(size: 16, weight: .semibold))
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
                            .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            Button {
                                showConfirmationForDeletingOldDeadlines = true
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
                // TODO: - Move no deadlines view to its own component
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
            .alert(
                "Are you sure you want to delete all expired deadlines?",
                isPresented: $showConfirmationForDeletingOldDeadlines,
                actions: {
                    Button(role: .destructive) {
                        deadlineManager.delete(deadlines: deadlineManager.expiredDeadlines)
                        showConfirmationForDeletingOldDeadlines = false
                    } label: {
                        Text("Delete")
                    }
                    
                    Button(role: .cancel) {
                        showConfirmationForDeletingOldDeadlines = false
                    } label: {
                        Text("Cancel")
                    }

                }
                // TODO: - Refactor alert into its own view
            )
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
