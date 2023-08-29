//
//  DeadlineForm.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import SwiftUI

struct NewDeadlineForm: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            ImagePickerView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: {
                    self.addDummyDeadline()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
                })
            }
        })
    }
    
}

extension NewDeadlineForm {
    
    func addDummyDeadline() {
        modelContext.insert(Deadline(
            title: "Dummy Deadline",
            body: "Testing Testing Testing Testing Testing Testing Testing ",
            endDate: Date.now + TimeInterval(7200),
            creationDate: Date.now,
            imageData: nil
        ))
    }
    
}

#Preview {
    return NavigationView {
        NewDeadlineForm()
    }
}
