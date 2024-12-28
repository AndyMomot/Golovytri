//
//  CalculatorView.swift
//  Golovytri
//
//  Created by Andrii Momot on 28.12.2024.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.greenCustom
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Kalkulačka zdrojů")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 25))
                    Spacer()
                }
                .padding()
                
                ZStack {
                    Asset.background.swiftUIImage
                        .resizable()
                    
                    VStack {
                        ScrollView {
                            VStack(spacing: 20) {
                                
                                // Main task
                                ZStack {
                                    Circle()
                                        .fill(viewModel.priorityColor)
                                        .overlay {
                                            if let image = viewModel.image {
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .clipShape(Circle())
                                                    .padding(2)
                                            } else {
                                                Image(systemName: "questionmark")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(.white)
                                                    .padding()
                                            }
                                        }
                                }
                                .frame(width: bounds.width * 0.55,
                                       height: bounds.width * 0.55)
                                
                                Text(viewModel.mainTask?.name ?? "")
                                    .foregroundStyle(.darkBlue)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 25))
                                
                                ZStack {
                                    Color.greenCustom
                                    HStack {
                                        VStack(spacing: 10) {
                                            Text("Datum splatnosti")
                                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                                            Text(viewModel.mainTask?.date.toString(format: .ddMMyyyy) ?? "")
                                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(spacing: 10) {
                                            Text("Čas")
                                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                                            Text("\(viewModel.mainTask?.days ?? .zero) dní")
                                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(spacing: 10) {
                                            Text("Rozpočet")
                                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                                            Text("\(viewModel.mainTask?.budget ?? .zero)")
                                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                        }
                                    }
                                    .foregroundStyle(.white)
                                    .padding()
                                }
                                
                                // Subtasks
                                VStack(spacing: 15) {
                                    ForEach(viewModel.subtasks) { person in
                                        PersonCell(
                                            person: person, canEdit: viewModel.isEditing,
                                            showLoading: viewModel.showLoading) { action in
                                                viewModel.handle(action: action, for: person)
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .scrollIndicators(.never)
                        
                        NextButton(title: viewModel.isEditing ? "Uložit" : "Přerozdělení zdrojů") {
                            withAnimation {
                                viewModel.isEditing.toggle()
                            }
                        }
                        .frame(height: 52)
                        .padding(.horizontal, 26)
                        .padding(.bottom)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getTasks()
        }
    }
}

#Preview {
    CalculatorView()
}
