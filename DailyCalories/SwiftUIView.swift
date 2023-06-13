//
//  SwiftUIView.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 13.06.2023.
//

import SwiftUI

struct SwiftUIView: View {
    var food: Food
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                Image("food")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: geometry.size.height * 0.4)
                    .padding(.horizontal)
                
                Name(name: food.name ?? "")
                    .font(.title)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    NutritionalInfo(label: "Calories", value:  food.calories, unit: "g")
                    NutritionalInfo(label: "Proteins", value:  food.protein, unit: "g")
                    NutritionalInfo(label: "Carbohydrates", value:  food.carbohydrates, unit: "g")
                    NutritionalInfo(label: "Fats", value: food.fat, unit: "g")
                    NutritionalInfo(label: "Fats", value: food.fat, unit: "g")
                        .subInfo("Saturated fats", value: String(format: "%.2f", food.saturatedFat))
                    NutritionalInfo(label: "Fiber", value:  food.fiber, unit: "g")
                    NutritionalInfo(label: "Sugar", value:  food.sugar, unit: "g")
                    NutritionalInfo(label: "Sodium", value: food.sodium, unit: "mg")
                    NutritionalInfo(label: "Potassium", value:  food.potassium, unit: "mg")
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}


struct Name: View {
    var name: String
    var body: some View {
        HStack {
            Text(name.capitalized)
        }
    }
}

struct NutritionalInfo: View {
    var label: String
    var value: Double
    var unit: String
    @ViewBuilder
    func subInfo(_ subLabel: String, value: String) -> some View {
        HStack {
            Text(subLabel)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: 120, alignment: .leading)
            Spacer()
            Text(String(format: "%.2f %@",value, unit))
        }
    }
    
    
}
