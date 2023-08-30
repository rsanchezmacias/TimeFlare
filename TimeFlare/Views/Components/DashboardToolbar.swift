//
//  DashboardToolbar.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import SwiftUI
import SwiftData

struct DashboardToolbar<Content: View>: ToolbarContent {
    
    @ViewBuilder var addDeadlineContent: () -> Content
    @Environment(\.editMode) private var editMode
    
    @Binding var editButtonVisible: Bool
    
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
        }
    }
    
}

#Preview {
    return NavigationView(content: {
        Text("PlaceHolder")
            .toolbar(content: {
                DashboardToolbar(addDeadlineContent: {
                    Text("Add")
                }, editButtonVisible: .constant(true))
            })
    })
}
