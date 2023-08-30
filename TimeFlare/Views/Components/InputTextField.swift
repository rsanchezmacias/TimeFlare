//
//  InputTextField.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/29/23.
//

import SwiftUI
import Combine

struct InputTextField: View {
    
    @Binding var currentInput: String
    var topLabelText: String
    var textFieldPlaceholderText: String
    var axis: Axis
    
    @FocusState var focused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text(topLabelText)
                .font(.headline)
            
            TextField(text: $currentInput, axis: axis) {
                Text(textFieldPlaceholderText)
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(nil)
            .focused($focused)
            .toolbar {
                if focused {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button(action: {
                                focused = false
                            }, label: {
                                Text("Done")
                            })
                        }
                    }
                }
            }
            
            Rectangle()
                .fill(focused ? Color.charcoal : Color.gray)
                .frame(height: 2)
        }

    }
    
}

#Preview {
    InputTextField(
        currentInput: .constant(""),
        topLabelText: "Title",
        textFieldPlaceholderText: "Deadline...",
        axis: .vertical
    )
    .padding()
}
