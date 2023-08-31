//
//  DeadlineView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/30/23.
//

import SwiftUI

struct DeadlineView: View {
    
    var deadline: Deadline
    
    @State private var editing: Bool = false
    
    @State private var newTitleText: String = ""
    @State private var newDescriptionText: String = ""
    @State private var newDeadlineImage: UIImage?
    
    var body: some View {
        GeometryReader(content: { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Rectangle()
                            .fill(Color.clear)
                            .overlay {
                                if let newDeadlineImage = newDeadlineImage {
                                    Image(uiImage: newDeadlineImage)
                                        .deadlineThumbnail()
                                } else {
                                    deadline.image?
                                        .deadlineThumbnail()
                                }
                            }
                            .overlay {
                                if editing {
                                    ImagePickerView(selectedUIImage: $newDeadlineImage)
                                }
                            }
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: geometry.size.width * 0.75)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: editing ? 16 : 8) {
                        VStack {
                            if editing {
                                InputTextField(
                                    currentInput: $newTitleText,
                                    topLabelText: "Updated Title",
                                    textFieldPlaceholderText: "Deadline title...",
                                    axis: .horizontal
                                )
                            } else {
                                Text(deadline.title)
                                    .font(.system(size: 18, weight: .bold))
                            }
                        }
                        
                        VStack {
                            if editing {
                                InputTextField(
                                    currentInput: $newDescriptionText,
                                    topLabelText: "Updated Description",
                                    textFieldPlaceholderText: "What deadline is approaching?",
                                    axis: .vertical
                                )
                            } else if let body = deadline.body {
                                Text(body)
                                    .font(.system(size: 14))
                            }
                        }
                    }
                    .padding(.top, 24)
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 32)
                .padding(.top, 40)
                .toolbar {
                    if !editing {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                withAnimation {
                                    editing = true
                                }
                            }, label: {
                                Text("Edit")
                            })
                        }
                    } else {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                withAnimation {
                                    editing = false
                                }
                                onCancel()
                            }, label: {
                                Text("Cancel")
                            })
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                withAnimation {
                                    editing = false
                                }
                                onSave()
                            }, label: {
                                Text("Save")
                            })
                        }
                    }
                }
                .onAppear(perform: {
                    newTitleText = deadline.title
                    newDescriptionText = deadline.body ?? ""
                })
                
            }
        })
    }
    
    private func onSave() {
        deadline.title = newTitleText
        deadline.imageData = newDeadlineImage?.toData()
        deadline.body = newDescriptionText
    }
    
    private func onCancel() {
        newTitleText = deadline.title
        newDeadlineImage = nil
        newDescriptionText = deadline.body ?? ""
    }
    
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    let deadlines = SampleDeadline.sampleDeadlines
    return NavigationView(content: {
        DeadlineView(deadline: deadlines[0])
            .modelContainer(container)
    })
}
