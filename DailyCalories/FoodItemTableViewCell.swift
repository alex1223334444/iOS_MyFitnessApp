//
//  FoodItemTableViewCell.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 05.03.2023.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {
    private var foodItem: FoodItem!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFoodItem()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFoodItem()
    }

    private func setupFoodItem() {
        foodItem = FoodItem()
        foodItem.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(foodItem)

        // Set up constraints for the foodItem view
        NSLayoutConstraint.activate([
            foodItem.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodItem.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            foodItem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configureFoodCell(_ name: String, calories: Int, tag: Int = 0) {
        foodItem.configureFoodItem(with: name, caloriesNr: calories, tag: tag)
    }
}

