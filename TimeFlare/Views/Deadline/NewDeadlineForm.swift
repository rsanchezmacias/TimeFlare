//
//  DeadlineForm.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import SwiftUI
import UIKit

struct NewDeadlineForm: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    
    @State var deadlineImage: UIImage?
    @State var titleText: String = ""
    @State var bodyText: String = ""
    @State var deadlineDate: Date = Date.now
    
    @State var doneButtonDisabled: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                HStack {
                    Spacer()
                    ImagePickerView(selectedUIImage: $deadlineImage)
                        .padding([.top], 32)
                    Spacer()
                }
                
                VStack(alignment: .trailing, spacing: 16, content: {
                    InputTextField(
                        currentInput: $titleText,
                        topLabelText: "Title",
                        textFieldPlaceholderText: "Deadline...",
                        axis: .horizontal
                    )
                    
                    InputDatePicker(
                        date: $deadlineDate,
                        inDateRange: Date.now...,
                        titleLabel: "When is your deadline?",
                        subtitleLabel: "Date:"
                    )
                    
                    InputTextField(
                        currentInput: $bodyText,
                        topLabelText: "Description",
                        textFieldPlaceholderText: "What is approaching...",
                        axis: .vertical
                    )
                })
                .font(.subheadline)
            }
            .padding([.leading, .trailing], 32)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        self.addDummyDeadline()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Done")
                    })
                    .disabled(titleText.isEmpty)
                }
            })
        }
    }
    
}

extension NewDeadlineForm {
    
    func addDummyDeadline() {
        modelContext.insert(Deadline(
            title: titleText,
            body: bodyText,
            endDate: deadlineDate,
            creationDate: Date.now,
            imageData: deadlineImage?.toData()
        ))
    }
    
}

#Preview {
    return NavigationView {
        NewDeadlineForm()
    }
}
