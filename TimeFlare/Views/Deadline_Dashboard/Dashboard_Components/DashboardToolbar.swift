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
    
    @Binding var editMode: EditMode
    @Binding var editButtonVisible: Bool
    @Binding var sortButtonVisible: Bool
    
    @State private var pickingSortType: SortType = .ascendingDate
    
    private let toolbarButtonSize: CGFloat = 44
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            LazyHStack {
                Image.appIconTransparent
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text("TimeFlare")
                    .font(.system(size: 20))
                    .bold()
                Spacer()
            }
        }
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            LazyHStack(alignment: .center) {
                
                if sortButtonVisible && $editMode.wrappedValue == .inactive {
                    Menu {
                        Picker(selection: $pickingSortType) {
                            ForEach(SortType.allCases, id: \.self) { sortType in
                                Text(sortType.displayText).tag(sortType.rawValue)
                            }
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down")
                        }
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                    .squareFrame(side: toolbarButtonSize)
                    .toolbarButton()
                }
                
                if editButtonVisible {
                    Button(action: {
                        withAnimation {
                            if $editMode.wrappedValue == .active {
                                $editMode.wrappedValue = .inactive
                            } else {
                                $editMode.wrappedValue = .active
                            }
                        }
                    }, label: {
                        Image(systemName: ($editMode.wrappedValue == .inactive) ? "square.and.pencil" : "checkmark.square")
                    })
                    .squareFrame(side: toolbarButtonSize)
                    .toolbarButton()
                    .padding(.bottom, ($editMode.wrappedValue == .inactive) ? 3 : 0)
                }
                
                if $editMode.wrappedValue == .inactive {
                    NavigationLink {
                        addDeadlineContent()
                    } label: {
                        Image(systemName: "plus.app")
                    }
                    .squareFrame(side: toolbarButtonSize)
                    .toolbarButton()
                }
            }
            .animation(.easeOut, value: UUID())
            .onAppear(perform: {
                pickingSortType = deadlineManager.sortBy
            })
            .onChange(of: pickingSortType, initial: false) {
                deadlineManager.setSortPreference(sortBy: pickingSortType)
            }
            
        }
    }
    
}

extension View {
    
    func toolbarButton() -> some View {
        self.foregroundColor(Color.charcoal)
    }
    
}

#Preview {
    let deadlineManager = DeadlineManager(container: SampleDeadline.sampleDeadlineContainer)
    return NavigationStack(root: {
        Text("PlaceHolder")
            .toolbar(content: {
                DashboardToolbar(
                    addDeadlineContent: { Text("Add") },
                    editMode: .constant(.inactive),
                    editButtonVisible: .constant(true),
                    sortButtonVisible: .constant(true)
                )
            })
            .environmentObject(deadlineManager)
    })
}
