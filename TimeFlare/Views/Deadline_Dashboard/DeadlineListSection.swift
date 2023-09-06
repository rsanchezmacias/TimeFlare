//
//  DeadlineListSection.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI

struct DeadlineListSection<HeaderRightContent: View>: View {
    
    @EnvironmentObject private var deadlineManager: DeadlineManager
    
    var deadlines: [Deadline]
    var headerTitle: String
    var headerTitleIconName: String
    var headerRightContent: HeaderRightContent?
    
    init(
        deadlines: [Deadline],
        headerTitle: String,
        headerTitleIconName: String,
        @ViewBuilder headerRightContent: () -> HeaderRightContent? = { EmptyView() }
    ) {
        self.deadlines = deadlines
        self.headerTitle = headerTitle
        self.headerTitleIconName = headerTitleIconName
        self.headerRightContent = headerRightContent()
    }
    
    var body: some View {
        Section {
            ForEach(deadlines) { deadline in
                if !deadline.title.isEmpty {
                    NavigationLink {
                        DeadlineDetails(deadline: deadline)
                    } label: {
                        DeadlineRow(deadline: deadline)
                    }
                }
            }
            .onDelete { indexSet in
                deadlineManager.deleteDeadlineInIndexSetFromList(
                    indexSet: indexSet,
                    deadlines: deadlines
                )
            }
        } header: {
            HStack(alignment: .center) {
                Label(headerTitle, systemImage: headerTitleIconName)
                .font(.system(size: 16, weight: .semibold))
                Spacer()
                headerRightContent
            }
        }
    }
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    let manager = DeadlineManager(container: container)
    manager.refreshDeadlines()
    
    return List {
        DeadlineListSection(
            deadlines: manager.allDeadlines,
            headerTitle: "Ongoing",
            headerTitleIconName: "clock.badge.checkmark") {
                Button {
                    // Do nothing
                } label: {
                    Label("Delete expired deadlines", systemImage: "trash")
                        .labelStyle(.iconOnly)
                        .foregroundStyle(Color.red)
                }
            }
            .environmentObject(manager)
    }
}
