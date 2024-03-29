//
//  FoodModel.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 30.12.2022.
//
import Foundation

struct FoodRequested: Codable {
    var name: String
    var calories: Double
    var serving_size_g: Double
    var fat_total_g: Double
    var fat_saturated_g: Double
    var protein_g: Double
    var sodium_mg: Double
    var potassium_mg: Double
    var cholesterol_mg: Double
    var carbohydrates_total_g: Double
    var fiber_g: Double
    var sugar_g: Double
    
    /*private enum CodingKeys: String, CodingKey {
        case name
        case calories
        case serving_size_g
        case fat_total_g
        case fat_saturated_g
        case protein_g
        case sodium_mg
        case potassium_mg
        case cholesterol_mg
        case carbohydrates_total_g
        case fiber_g
        case sugar_b
        
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        calories = try container.decode(Double.self, forKey: .calories)
        serving_size_g = try container.decode(Double.self, forKey: .serving_size_g)
        fat_total_g = try container.decode(Double.self, forKey: .fat_total_g)
        fat_saturated_g = try container.decode(Double.self, forKey: .fat_saturated_g)
        protein_g = try container.decode(Double.self, forKey: .protein_g)
        sodium_mg = try container.decode(Double.self, forKey: .sodium_mg)
        potassium_mg = try container.decode(Double.self, forKey: .potassium_mg)
        cholesterol_mg = try container.decode(Double.self, forKey: .cholesterol_mg)
        carbohydrates_total_g = try container.decode(Double.self, forKey: .carbohydrates_total_g)
        fiber_g = try container.decode(Double.self, forKey: .fiber_g)
        sugar_g = try container.decode(Double.self, forKey: .sugar_b)

    }*/
    init(name: String, calories: Double, serving_size_g: Double, fat_total_g: Double, fat_saturated_g: Double, protein_g: Double, sodium_mg: Double, potassium_mg: Double, cholesterol_mg: Double, carbohydrates_total_g: Double, fiber_g: Double, sugar_g: Double) {
            self.name = name
            self.calories = calories
            self.serving_size_g = serving_size_g
            self.fat_total_g = fat_total_g
            self.fat_saturated_g = fat_saturated_g
            self.protein_g = protein_g
            self.sodium_mg = sodium_mg
            self.potassium_mg = potassium_mg
            self.cholesterol_mg = cholesterol_mg
            self.carbohydrates_total_g = carbohydrates_total_g
            self.fiber_g = fiber_g
            self.sugar_g = sugar_g
        }
}

/*struct Food : Codable {
    //var foods : FoodRequested
    var uid : String?
    var name: String?
    var calories: Double?
    var serving_size_g: Double?
    var fat_total_g: Double?
    var fat_saturated_g: Double?
    var protein_g: Double?
    var sodium_mg: Double?
    var potassium_mg: Double?
    var cholesterol_mg: Double?
    var carbohydrates_total_g: Double?
    var fiber_g: Double?
    var sugar_g: Double?
    /*private enum CodingKeys: String, CodingKey {
        case foods = "foods"
        case uid = "uid"
        
        
    }*/
}*/
