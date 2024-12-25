//
//  TaskView.swift
//  Golovytri
//
//  Created by Andrii Momot on 25.12.2024.
//

import SwiftUI

struct TaskView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    let viewState: ViewState
    
    var body: some View {
        ZStack {
            Color.greenCustom
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text(viewModel.isEditing ? "Upravit úkol" : "Přidání úkolu")
                        }
                    }

                    Spacer()
                    
                    if viewModel.isEditing {
                        Button {
                            dismiss.callAsFunction()
                        } label: {
                            Image(systemName: "trash")
                            
                        }
                    }
                }
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 25))
                .padding()
                
                ZStack {
                    Asset.background.swiftUIImage
                        .resizable()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            // Image
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(.greenCustom)
                                        .overlay {
                                            if viewModel.image == UIImage() {
                                                Image(systemName: "questionmark")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(.white)
                                                    .padding()
                                            } else {
                                                Image(uiImage: viewModel.image)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .clipShape(Circle())
                                                    .padding(2)
                                            }
                                        }
                                        .padding(.top)
                                        .padding(.horizontal, 150)
                                }

                                Button {
                                    viewModel.showImagePicker.toggle()
                                } label: {
                                    Text(viewModel.isEditing ? "Nahradit fotografii" : "Přidat fotografii")
                                        .foregroundStyle(.darkBlue)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(fixedSize: 16))
                                        .padding(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.darkBlue, lineWidth: 1)
                                        }
                                }
                            }
                            
                            // Fields
                            InputField(title: "Název úlohy",
                                       text: $viewModel.name)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Čas splatnosti")
                                    .foregroundStyle(.darkBlue)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)
                                
                                ZStack {
                                    Color.white
                                        .cornerRadius(8, corners: .allCorners)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(.darkBlue, lineWidth: 1)
                                        }
                                    
                                    DatePicker("", selection: $viewModel.date,
                                               in: Date()...,
                                               displayedComponents: .date)
                                    .padding(8)
                                }
                            }
                            
                            InputField(title: "Čas (dní)",
                                       text: $viewModel.days)
                            .keyboardType(.numberPad)
                            
                            InputField(title: "Rozpočet",
                                       text: $viewModel.budget)
                            .keyboardType(.numberPad)
                            
                            InputField(title: "Další zdroje",
                                       text: $viewModel.budget)
                            
                            MenuPicker(title: "Priorita úlohy",
                                       items: viewModel.priorityItems,
                                       selection: $viewModel.priority)
                            
                            DynamicHeightTextField(title: "Popis úkolu",
                                                   text: $viewModel.description)
                            .frame(minHeight: 100)
                            
                            // Buttons
                            
                            NextButton(title: "Uložit") {
                                
                            }
                        }
                        .padding()
                    }
                    .scrollIndicators(.never)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.configure(state: viewState)
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
    }
}

#Preview {
    TaskView(viewState: .edit(.init(
        name: "name",
        date: .init(),
        days: 12,
        budget: 3232,
        resources: "resources",
        priority: .high,
        description: "description")))
}
