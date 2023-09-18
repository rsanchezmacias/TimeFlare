//
//  DeadlineView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/30/23.
//

import SwiftUI

struct DeadlineDetailsImageView: View {
    
    var image: Image?
    var frameSize: CGFloat
    
    @Binding var editing: Bool
    @Binding var pickedUIImage: UIImage?
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.metal)
                .opacity(0.2)
                .frame(width: frameSize, height: frameSize)
                .clipShape(.rect(cornerRadius: 8))
                .offset(x: 3, y: 3)
            
            CenteredHStack {
                ImageThumbnail(image: image)
                    .frame(width: frameSize, height: frameSize)
                    .overlay {
                        if editing {
                            ImagePickerView(selectedUIImage: $pickedUIImage)
                        }
                    }
                    
            }
            .offset(x: -3, y: -3)
        }
        
    }
    
}

struct DeadlineDetails: View {
    
    var deadline: Deadline
    
    @EnvironmentObject private var deadlineManager: DeadlineManager
    @Injected(\.widgetUpdateManager) private var widgetUpdateManager
    
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
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    DeadlineDetailsImageView(
                        image: newDeadlineImage ?? deadline.image,
                        frameSize: geometry.size.width * 0.75,
                        editing: $editing,
                        pickedUIImage: $newDeadlineUIImage
                    )
                    
                    VStack(alignment: .leading, spacing: editing ? 16 : 8) {
                        
                        PrimaryWithSecondaryView(primary: {
                            InputTextField(
                                currentInput: $newTitleText,
                                topLabelText: "Updated Title",
                                textFieldPlaceholderText: "Deadline title...",
                                axis: .horizontal
                            )
                        }, secondary: {
                            DeadlineDetailsTitle(deadline: deadline) {
                                deadlineManager.setAsFeatured(
                                    deadline,
                                    featured: !deadline.featured
                                )
                            }
                        }, showPrimary: editing)
                        
                        PrimaryWithSecondaryView(primary: {
                            InputTextField(
                                currentInput: $newDescriptionText,
                                topLabelText: "Updated Description",
                                textFieldPlaceholderText: "What deadline is approaching?",
                                axis: .vertical
                            )
                        }, secondary: {
                            if let body = deadline.body {
                                Text(body)
                                    .font(.system(size: 14))
                            }
                        }, showPrimary: editing)
                    }
                    .padding(.top, 24)
                    
                    PrimaryWithSecondaryView(primary: {
                        InputDatePicker(
                            date: $newDeadlineDate,
                            titleLabel: "What is the new deadline?",
                            subtitleLabel: "Updated date:"
                        )
                    }, secondary: {
                        Divider()
                        DeadlineDetailCountdownView(deadline: deadline)
                    }, showPrimary: editing)
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 32)
                .padding(.top, 48)
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
    
}

extension DeadlineDetails {
    
    private func onSave() {
        deadline.title = newTitleText
        deadline.body = newDescriptionText
        
        if newDeadlineDate > Date.now {
            deadline.endDate = newDeadlineDate
        } else {
            deadline.endDate = newDeadlineDate + TimeInterval(60)
        }
        
        if newDeadlineUIImage != nil {
            deadline.imageData = newDeadlineUIImage?.toData()
        }
        
        widgetUpdateManager.setAsDirtyIfNeeded(affectedDeadline: deadline)
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
    let manager = DeadlineManager(container: container)
    
    return NavigationStack(root: {
        DeadlineDetails(deadline: deadlines[4])
    })
    .environmentObject(manager)
}
