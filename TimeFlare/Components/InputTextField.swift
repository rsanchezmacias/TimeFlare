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
            .font(.system(size: 14))
            .textInputAutocapitalization(nil)
            .focused($focused)
            .onChange(of: currentInput, { oldValue, newValue in
                if let last = newValue.last, last.isNewline {
                    focused = false
                    currentInput = oldValue
                }
            })
            
            Rectangle()
                .fill(focused ? Color.charcoal : Color.gray)
                .frame(height: 2)
                .padding(.top, 2)
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
