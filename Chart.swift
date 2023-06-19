//
//  Chart.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 19.06.2023.
//

import SwiftUI
import Charts


struct BarChart: View {
    var data: [String] = ["Protein g", "Carbs g", "Fats g"]
    var proteins: Double
    var carbs: Double
    var fats: Double
    var body: some View {
        Chart {
            BarMark(
                    x: .value("Shape Type", data[0]),
                    y: .value("Total Count", proteins)
                )
                BarMark(
                     x: .value("Shape Type", data[1]),
                     y: .value("Total Count", carbs)
                )
                BarMark(
                     x: .value("Shape Type", data[2]),
                     y: .value("Total Count", fats)
                )
        }
    }
}



struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(proteins: 10, carbs: 20, fats: 30)
    }
}
