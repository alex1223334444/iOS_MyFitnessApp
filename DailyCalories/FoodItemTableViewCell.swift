//
//  FoodItemTableViewCell.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 05.03.2023.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodItem: FoodItem!
    func configureFoodCell(_ placeholder: String, tag: Int = 0 ){
        foodItem.configureFoodItem(with: placeholder, tag: tag)
      }
    
}
