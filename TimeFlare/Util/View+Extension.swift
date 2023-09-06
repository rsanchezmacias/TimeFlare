//
//  View+Extension.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI

extension View {
    
    func overlayWithNavigationTo<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        overlay {
            NavigationLink {
                content()
            } label: {
                EmptyView()
            }
            .opacity(0)
        }
    }
    
    func deleteExpiredDeadlinesAlert(
        isPresented: Binding<Bool>,
        title: String,
        mainAction: @escaping Thunk,
        hideAction: @escaping Thunk
    ) -> some View {
        return self.alert(
            title,
            isPresented: isPresented,
            actions: {
                Button(role: .destructive) {
                    mainAction()
                    hideAction()
                } label: {
                    Text("Delete")
                }
                
                Button(role: .cancel) {
                    hideAction()
                } label: {
                    Text("Cancel")
                }
            }
        )
    }
    
    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
    
}
