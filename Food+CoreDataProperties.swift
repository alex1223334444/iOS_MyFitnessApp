//
//  Food+CoreDataProperties.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 16.05.2023.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var calories: Double
    @NSManaged public var carbohydrates: Double
    @NSManaged public var fat: Double
    @NSManaged public var fiber: Double
    @NSManaged public var name: String?
    @NSManaged public var potassium: Double
    @NSManaged public var protein: Double
    @NSManaged public var saturatedFat: Double
    @NSManaged public var servingSize: Double
    @NSManaged public var sodium: Double
    @NSManaged public var sugar: Double
    @NSManaged public var user: User?

}

extension Food : Identifiable {

}
