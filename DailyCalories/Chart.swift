//
//  Chart.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 19.06.2023.
//

import SwiftUI
import Charts


struct BarChart: View {
    var data: [String] = ["Protein", "Carbs", "Fats"]
    var proteins: Double
    var carbs: Double
    var fats: Double
    var body: some View {
        let maxVal = max(proteins, carbs, fats) + 100
        let yMarkValues = stride(from: 0, to: maxVal, by: 100).map{ $0 }

        Chart {
            BarMark(
                x: .value("Shape Type", data[0]),
                y: .value("Total Count", proteins)
            )
            .annotation(position: .overlay, alignment: .center) {
                Text("\(Int(proteins)) kcal")
                
            }
            BarMark(
                x: .value("Shape Type", data[1]),
                y: .value("Total Count", carbs)
            )
            .annotation(position: .overlay, alignment: .center) {
                Text("\(Int(carbs)) kcal")
            }
            BarMark(
                x: .value("Shape Type", data[2]),
                y: .value("Total Count", fats)
            )
            .annotation(position: .overlay, alignment: .center) {
                Text("\(Int(fats)) kcal")
            }
        }
        .chartYAxis {
            AxisMarks(values: yMarkValues)
        }
        .foregroundStyle(.green)
        
    }
}



struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(proteins: 10, carbs: 20, fats: 30)
    }
}
