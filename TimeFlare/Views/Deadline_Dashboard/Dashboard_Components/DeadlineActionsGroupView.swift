//
//  DeadlineActionsGroupView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 6/14/25.
//

import SwiftUI

struct DeadlineActionsGroupView<DeadlineContent: View>: View {
    
    @EnvironmentObject private var deadlineManager: DeadlineManager
    
    @ViewBuilder var addDeadlineContent: () -> DeadlineContent
    
    @Binding var editMode: EditMode
    @Binding var editButtonVisible: Bool
    @Binding var sortButtonVisible: Bool
     
    @State private var pickingSortType: SortType = .ascendingDate
    
    private let toolbarButtonSize: CGFloat = 44
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            HStack(spacing: 8) {
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
                    .actionButton()
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
                    .actionButton()
                    .padding(.bottom, ($editMode.wrappedValue == .inactive) ? 3 : 0)
                }
            }
            .background(
                Capsule()
                    .fill(Color.primary.opacity(0.1))
                    .background(
                        Capsule()
                            .fill(.regularMaterial)
                    )
            )
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
            
            if $editMode.wrappedValue == .inactive {
                NavigationLink {
                    addDeadlineContent()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.white)
                }
                .frame(width: toolbarButtonSize, height: toolbarButtonSize)
                .background(
                    Circle()
                        .fill(Color.forestGreen)
                )
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
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

extension View {
    func actionButton() -> some View {
        self.foregroundStyle(Color.primary)
    }
}

