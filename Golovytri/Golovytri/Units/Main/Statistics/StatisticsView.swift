//
//  StatisticsView.swift
//  Golovytri
//
//  Created by Andrii Momot on 28.12.2024.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.greenCustom
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Statistiky")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 25))
                    Spacer()
                }
                .padding()
                
                ZStack {
                    Asset.background.swiftUIImage
                        .resizable()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Výkonnostní graf")
                                    .foregroundStyle(.darkBlue)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 22))
                                
                                Chart {
                                    ForEach(viewModel.barChartData, id: \.date) { dataPoint in
                                        BarMark(
                                            x: .value("Date 3", dataPoint.date, unit: .day),
                                            y: .value("Task Count 3", dataPoint.high)
                                        )
                                        .foregroundStyle(.redCustom)
                                    }
                                    
                                    ForEach(viewModel.barChartData, id: \.date) { dataPoint in
                                        BarMark(
                                            x: .value("Date 2", dataPoint.date, unit: .day),
                                            y: .value("Task Count 2", dataPoint.medium)
                                        )
                                        .foregroundStyle(.orangeCustom)
                                    }
                                    
                                    ForEach(viewModel.barChartData, id: \.date) { dataPoint in
                                        BarMark(
                                            x: .value("Date 1", dataPoint.date, unit: .day),
                                            y: .value("Task Count 1", dataPoint.low)
                                        )
                                        .foregroundStyle(.greenCustom)
                                        .cornerRadius(12)
                                    }
                                }
                                .padding(.horizontal)
                                .chartYAxis(.hidden)
                                .chartXAxis {
                                    AxisMarks(values: viewModel.barChartData.map { $0.date }) { date in
                                        AxisValueLabel(format: .dateTime.day().month(.narrow).year())
                                    }
                                }
                                
                                IndicatorView()
                            }
                            .padding()
                            
                            HStack(spacing: 20) {
                                CircularProgressBar(
                                    progress: viewModel.highPercent,
                                    showProgress: true,
                                    trackColor: .darkBlue,
                                    progressColor: .redCustom,
                                    lineWidth: 20,
                                    textColor: .darkBlue,
                                    font: Fonts.SFProDisplay.bold.swiftUIFont(size: 26)
                                )
                                
                                CircularProgressBar(
                                    progress: viewModel.mediumPercent,
                                    showProgress: true,
                                    trackColor: .darkBlue,
                                    progressColor: .orangeCustom,
                                    lineWidth: 20,
                                    textColor: .darkBlue,
                                    font: Fonts.SFProDisplay.bold.swiftUIFont(size: 26)
                                )
                                
                                CircularProgressBar(
                                    progress: viewModel.lowPercent,
                                    showProgress: true,
                                    trackColor: .darkBlue,
                                    progressColor: .greenCustom,
                                    lineWidth: 20,
                                    textColor: .darkBlue,
                                    font: Fonts.SFProDisplay.bold.swiftUIFont(size: 26)
                                )
                            }
                            .padding(.horizontal)
                            .scrollIndicators(.never)
                            .frame(height: bounds.width * 0.3)
                            
                            IndicatorView()
                                .padding(.horizontal)
                            
                            // Tasks
                            VStack(spacing: 15) {
                                ForEach(viewModel.tasks) { person in
                                    PersonCell(
                                        person: person)
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
            viewModel.getTasks()
        }
    }
}

#Preview {
    StatisticsView()
}
