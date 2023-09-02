//
//  DashboardToolbar.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import SwiftUI
import SwiftData

struct DashboardToolbar<Content: View>: ToolbarContent {
    
    @EnvironmentObject private var deadlineManager: DeadlineManager
    
    @ViewBuilder var addDeadlineContent: () -> Content
    @Environment(\.editMode) private var editMode
    
    @Binding var editButtonVisible: Bool
    
    @State private var pickingSortType: SortType = .ascendingDate
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            LazyHStack {
                Image.appIconTransparent
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
                Text("TimeFlare")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
            }
        }
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            LazyHStack(alignment: .center) {
                
                if editMode?.wrappedValue == .inactive {
                    Menu("Sort") {
                        Picker(selection: $pickingSortType) {
                            ForEach(SortType.allCases, id: \.self) { sortType in
                                Text(sortType.displayText).tag(sortType.rawValue)
                            }
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down")
                        }
                    }
                }
                
                if editButtonVisible {
                    EditButton()
                }
                
                if editMode?.wrappedValue == .inactive {
                    NavigationLink {
                        addDeadlineContent()
                    } label: {
                        Text("Add")
                    }
                }
            }
            .animation(.none, value: UUID())
            .onAppear(perform: {
                pickingSortType = deadlineManager.sortBy
            })
            .onChange(of: pickingSortType, initial: false) {
                deadlineManager.setSortPreference(sortBy: pickingSortType)
            }
            
        }
    }
    
}

#Preview {
    let deadlineManager = DeadlineManager(container: SampleDeadline.sampleDeadlineContainer)
    return NavigationView(content: {
        Text("PlaceHolder")
            .toolbar(content: {
                DashboardToolbar(addDeadlineContent: {
                    Text("Add")
                }, editButtonVisible: .constant(true))
            })
            .environmentObject(deadlineManager)
    })
}
