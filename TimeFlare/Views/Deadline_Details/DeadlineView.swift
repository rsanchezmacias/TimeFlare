//
//  DeadlineView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/30/23.
//

import SwiftUI

struct DeadlineView: View {
    
    var deadline: Deadline
    
    @EnvironmentObject private var deadlineManager: DeadlineManager
    
    @State private var editing: Bool = false
    
    @State private var newTitleText: String = ""
    @State private var newDescriptionText: String = ""
    @State private var newDeadlineUIImage: UIImage?
    @State private var newDeadlineDate: Date = Date.now
    
    private var newDeadlineImage: Image? {
        guard let newDeadlineUIImage = newDeadlineUIImage else { return nil }
        return Image(uiImage: newDeadlineUIImage)
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    CenteredHStack {
                        ImageThumbnail(image: newDeadlineImage ?? deadline.image)
                            .frame(width: geometry.size.width * 0.75, height: geometry.size.width * 0.75)
                            .overlay {
                                if editing {
                                    ImagePickerView(selectedUIImage: $newDeadlineUIImage)
                                }
                            }
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
                                HStack {
                                    Text(deadline.title)
                                        .font(.system(size: 18, weight: .bold))
                                    Spacer()
                                    Button {
                                        deadlineManager.setAsFeatured(
                                            deadline,
                                            featured: !deadline.featured
                                        )
                                    } label: {
                                        Label("Set as featured deadline", systemImage: deadline.featured ? "star.fill" : "star" )
                                            .labelStyle(.iconOnly)
                                            .foregroundStyle(Color.yellow)
                                    }

                                }
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
                    
                    VStack(alignment: .leading, spacing: 8) {
                        if editing {
                            InputDatePicker(
                                date: $newDeadlineDate,
                                titleLabel: "What is the new deadline?",
                                subtitleLabel: "Updated date:"
                            )
                        } else {
                            Text(editing ? "Deadline" : "What is the new deadline?")
                                .font(.system(size: 16, weight: .bold))
                            
                            if deadline.endDate > Date.now {
                                CountdownDateTimer(endDate: deadline.endDate)
                                    .font(.system(size: 14))
                            } else {
                                Text("Deadline is over...")
                            }
                        }
                    }
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
                    onAppear()
                })
                
            }
        })
    }
    
    private func onSave() {
        deadline.title = newTitleText
        deadline.body = newDescriptionText
        deadline.endDate = newDeadlineDate
        
        if newDeadlineUIImage != nil {
            deadline.imageData = newDeadlineUIImage?.toData()
        }
    }
    
    private func onCancel() {
        newTitleText = deadline.title
        newDeadlineUIImage = nil
        newDescriptionText = deadline.body ?? ""
        newDeadlineDate = deadline.endDate
    }
    
    private func onAppear() {
        newDeadlineDate = deadline.endDate
        newTitleText = deadline.title
        newDescriptionText = deadline.body ?? ""
    }
    
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    let deadlines = SampleDeadline.sampleDeadlines
    return NavigationStack(root: {
        DeadlineView(deadline: deadlines[0])
            .modelContainer(container)
    })
}
