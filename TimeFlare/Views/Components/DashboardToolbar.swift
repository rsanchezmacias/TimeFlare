//
//  DashboardToolbar.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import SwiftUI

struct DashboardToolbar: ToolbarContent {
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            HStack {
                Image.appIconTransparent
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("TimeFlare")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
            }
        }
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            HStack(alignment: .center) {
                Button(action: {
                    
                }, label: {
                    Text("Add")
                })
            }
        }
    }
    
}

#Preview {
    return NavigationView(content: {
        Text("PlaceHolder")
            .toolbar(content: {
                DashboardToolbar()
            })
    })
}
