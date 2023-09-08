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
    
    @ObservedObject private var deepLinkModel = DeadlineDeepLinkModel()
    
    var body: some View {
        NavigationStack(path: $deepLinkModel.path, root: {
            
            List {
                
                if let featured = deadlineManager.featuredDeadline {
                    FeaturedDeadline(deadline: featured)
                    .listRowInsets(EdgeInsets())
                    .overlayWithNavigationTo {
                        DeadlineDetails(deadline: featured)
                    }
                }
                
                if !deadlineManager.ongoingDeadlines.isEmpty {
                    DeadlineListSection(
                        deadlines: deadlineManager.ongoingDeadlines,
                        headerTitle: "Ongoing deadlines",
                        headerTitleIconName: "clock"
                    )
                }
                
                if !deadlineManager.expiredDeadlines.isEmpty {
                    DeadlineListSection(
                        deadlines: deadlineManager.expiredDeadlines,
                        headerTitle: "Expired deadlines",
                        headerTitleIconName: "clock.badge.checkmark",
                        headerRightContent: {
                            Button {
                                showConfirmationForDeletingOldDeadlines = true
                            } label: {
                                Label("Delete expired deadlines", systemImage: "trash")
                                .labelStyle(.iconOnly)
                                .foregroundStyle(Color.red)
                            }
                        }
                    )
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                DashboardToolbar(
                    addDeadlineContent: {
                        NewDeadlineForm()
                    },
                    editButtonVisible: $editButtonVisible
                )
            }
            .overlay {
                if deadlineManager.allDeadlines.isEmpty {
                    EmptyDeadlinesView()
                    .offset(y: -150)
                }
            }
            .deleteExpiredDeadlinesAlert(
                isPresented: $showConfirmationForDeletingOldDeadlines,
                title: "Are you sure you want to delete all expired deadlines?",
                mainAction: {
                    deadlineManager.delete(deadlines: deadlineManager.expiredDeadlines)
                },
                hideAction: {
                    showConfirmationForDeletingOldDeadlines = false
                }
            )
            .onAppear {
                deadlineManager.refreshDeadlines()
            }
            .onChange(of: deadlineManager.allDeadlines, initial: false) { _, _ in
                editButtonVisible = !deadlineManager.allDeadlines.isEmpty
            }
            .onOpenURL { url in
                deepLinkModel.handleDeepLink(url: url, deadlines: deadlineManager.allDeadlines)
            }
            .navigationDestination(for: Deadline.self) { deadline in
                DeadlineDetails(deadline: deadline)
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
