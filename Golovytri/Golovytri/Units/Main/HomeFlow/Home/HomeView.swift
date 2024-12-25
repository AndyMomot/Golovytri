//
//  HomeView.swift
//  Golovytri
//
//  Created by Andrii Momot on 17.12.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.greenCustom
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Strom úkolů")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 25))
                    Spacer()
                }
                .padding()
                
                ZStack {
                    Asset.background.swiftUIImage
                        .resizable()
                        .ignoresSafeArea()
        
                    ScrollView {
                        VStack {
                            VStack(spacing: .zero) {
                                TreeView(people: viewModel.treeItems,
                                         priority: $viewModel.priority) { _ in
                                    
                                }
                                
                                ZStack {
                                    Color.greenCustom
                                    
                                    NextButton(title: "Přidání úkolu", borders: true) {
                                        viewModel.showAddTask.toggle()
                                    }
                                    .frame(height: 52)
                                    .padding(.horizontal, 26)
                                    .padding(.bottom)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.never)
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.showAddTask) {
            TaskView(viewState: .add)
        }
    }
}

#Preview {
    HomeView()
}
