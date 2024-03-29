//
//  FoodItemTableViewCell.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 05.03.2023.
//

import UIKit


protocol FoodItemTableViewCellDelegate: AnyObject {
    func deleteButtonTapped(for cell: FoodItemTableViewCell)
}

class FoodItemTableViewCell: UITableViewCell {
    private var foodItem: FoodItem!
    weak var delegate: FoodItemTableViewCellDelegate?

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
        
        contentView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.topAnchor.constraint(equalTo: foodItem.bottomAnchor, constant: -40).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()


        @objc private func deleteButtonTapped() {
            delegate?.deleteButtonTapped(for: self)
        }
    
    func configureFoodCell(_ name: String, calories: Int, tag: Int = 0) {
        foodItem.configureFoodItem(with: name, caloriesNr: calories, tag: tag)
    }
}

