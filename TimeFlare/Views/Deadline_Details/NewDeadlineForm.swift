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
    @EnvironmentObject private var deadlineManager: DeadlineManager
    
    @State var deadlineImage: UIImage?
    @State var titleText: String = ""
    @State var bodyText: String = ""
    @State var deadlineDate: Date = Date.now
    
    @State var doneButtonDisabled: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                
                CenteredHStack {
                    ImagePickerView(selectedUIImage: $deadlineImage)
                        .padding([.top], 32)
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
                        self.addDeadline()
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
    
    func addDeadline() {
        let endDate = deadlineDate > Date.now ? deadlineDate : Date(timeIntervalSinceNow: 60)
        
        deadlineManager.save(
            deadline: Deadline(
                title: titleText,
                body: bodyText,
                endDate: endDate,
                creationDate: Date.now,
                imageData: deadlineImage?.toData()
            )
        )
    }
    
}

#Preview {
    return NavigationStack {
        NewDeadlineForm()
    }
}
