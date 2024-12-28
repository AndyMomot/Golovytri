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
        NavigationStack {
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
                            VStack(spacing: 20) {
                                VStack(spacing: .zero) {
                                    TreeView(people: viewModel.treeItems,
                                             priority: $viewModel.priority) { person in
                                        viewModel.onSelectTreeItem(person)
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
                                
                                VStack(spacing: 15) {
                                    ForEach(viewModel.peopleForList) { person in
                                        Button {
                                            viewModel.onSelectPerson(person)
                                        } label: {
                                            PersonCell(person: person)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .scrollIndicators(.never)
                    }
                }
            }
            .onAppear {
                viewModel.getPeople()
            }
            .onChange(of: viewModel.priority) { _ in
                withAnimation {
                    viewModel.getPeople()
                }
            }
            .navigationDestination(isPresented: $viewModel.showAddTask) {
                TaskView(viewState: .add)
            }
            .navigationDestination(isPresented: $viewModel.showPersonDetails) {
                if let personToShow = viewModel.personToShow {
                    TaskView(viewState: .edit(personToShow))
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
