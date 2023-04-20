//
//  AddFoodViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 19.04.2023.
//

import UIKit

class AddFoodViewController: UIViewController, TextFieldWithLabelDelegate {
    func changeText(_ textContent: UITextField?) {
        //
    }
    
    var nameLabels = [UILabel]()
    var valueLabels = [UILabel]()
    
    fileprivate func constraintsFoodTextfield(_ foodText: Textfield) {
        NSLayoutConstraint.activate([
            foodText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            foodText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            foodText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -70),
            foodText.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    fileprivate func constraintsScanImage(_ image: UIImageView) {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            image.leadingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -70),
            image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    fileprivate func constraintsQuantityTextfield(_ quantityText: Textfield) {
        NSLayoutConstraint.activate([
            quantityText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 125),
            quantityText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            quantityText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -105),
            quantityText.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    fileprivate func constraintsWeightPicker(_ picker: WeightPicker) {
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 110),
            picker.leadingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100),
            picker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            picker.widthAnchor.constraint(equalToConstant: 100),
            picker.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
     func createLabelsInView(_ view: UIView) -> ([UILabel], [UILabel]) {
        // Create name labels
        let kcal = UILabel()
        kcal.text = "Calories:"
        let proteins = UILabel()
        proteins.text = "Proteins:"
        let carbs = UILabel()
        carbs.text = "Carbohydrates:"
        let fats = UILabel()
        fats.text = "Fats:"
        
        // Add name labels to view
        view.addSubview(kcal)
        view.addSubview(proteins)
        view.addSubview(carbs)
        view.addSubview(fats)
        
        // Set up constraints for the name labels
        kcal.translatesAutoresizingMaskIntoConstraints = false
        proteins.translatesAutoresizingMaskIntoConstraints = false
        carbs.translatesAutoresizingMaskIntoConstraints = false
        fats.translatesAutoresizingMaskIntoConstraints = false
        let margin: CGFloat = 20
        NSLayoutConstraint.activate([
            // Calories label constraints
            kcal.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            kcal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            
            // Proteins label constraints
            proteins.leadingAnchor.constraint(equalTo: kcal.leadingAnchor),
            proteins.topAnchor.constraint(equalTo: kcal.bottomAnchor, constant: margin),
            
            // Carbs label constraints
            carbs.leadingAnchor.constraint(equalTo: kcal.leadingAnchor),
            carbs.topAnchor.constraint(equalTo: proteins.bottomAnchor, constant: margin),
            
            // Fats label constraints
            fats.leadingAnchor.constraint(equalTo: kcal.leadingAnchor),
            fats.topAnchor.constraint(equalTo: carbs.bottomAnchor, constant: margin),
        ])
        
        // Set equal height for all name labels
        let heightConstraints = [
            fats.heightAnchor.constraint(equalToConstant: 20),
            kcal.heightAnchor.constraint(equalTo: proteins.heightAnchor),
            proteins.heightAnchor.constraint(equalTo: carbs.heightAnchor),
            carbs.heightAnchor.constraint(equalTo: fats.heightAnchor)
        ]
        NSLayoutConstraint.activate(heightConstraints)
        
        // Create value labels
        let kcalValue = UILabel()
        kcalValue.text = "0"
        kcalValue.font = UIFont.systemFont(ofSize: 16)
        let proteinsValue = UILabel()
        proteinsValue.text = "0"
        proteinsValue.font = UIFont.systemFont(ofSize: 16)
        let carbsValue = UILabel()
        carbsValue.text = "0"
        carbsValue.font = UIFont.systemFont(ofSize: 16)
        let fatsValue = UILabel()
        fatsValue.text = "0"
        fatsValue.font = UIFont.systemFont(ofSize: 16)
        
        // Add value labels to view
        view.addSubview(kcalValue)
        view.addSubview(proteinsValue)
        view.addSubview(carbsValue)
        view.addSubview(fatsValue)
        
        // Set up constraints for the value labels
        kcalValue.translatesAutoresizingMaskIntoConstraints = false
        proteinsValue.translatesAutoresizingMaskIntoConstraints = false
        carbsValue.translatesAutoresizingMaskIntoConstraints = false
        fatsValue.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Calories value constraints
            kcalValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            kcalValue.topAnchor.constraint(equalTo: kcal.topAnchor),
            
            // Proteins value constraints
            proteinsValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            proteinsValue.topAnchor.constraint(equalTo: proteins.topAnchor),
            
            // Carbs value constraints
            carbsValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            carbsValue.topAnchor.constraint(equalTo: carbs.topAnchor),
            
            // Fats value constraints
            fatsValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            fatsValue.topAnchor.constraint(equalTo: fats.topAnchor)
        ])
        
        // Set equal height for all value labels
        let valueHeightConstraints = [        kcalValue.heightAnchor.constraint(equalTo: proteinsValue.heightAnchor),        proteinsValue.heightAnchor.constraint(equalTo: carbsValue.heightAnchor),        carbsValue.heightAnchor.constraint(equalTo: fatsValue.heightAnchor)    ]
        NSLayoutConstraint.activate(valueHeightConstraints)
        
        // Return name and value labels as tuples
        return ([kcal, proteins, carbs, fats], [kcalValue, proteinsValue, carbsValue, fatsValue])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Create UI elements
        let foodText = Textfield()
        foodText.configureTextField(with: "Name the food", delegate: self, image: nil)
        foodText.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(foodText)
        
        let barScan = UIImageView()
        barScan.backgroundColor = .systemGreen
        barScan.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(barScan)
        
        let quantityText = Textfield()
        quantityText.configureTextField(with: "How much?", delegate: self, image: nil)
        quantityText.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(quantityText)
        
        let weightPicker = WeightPicker()
        weightPicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(weightPicker)
        
        let button = UIButton(type: .roundedRect)
        button.setTitle("Check food", for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.7)
        button.addTarget(self, action: #selector(checkFood(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        // Add constraints for UI elements
        constraintsFoodTextfield(foodText)
        constraintsScanImage(barScan)
        constraintsQuantityTextfield(quantityText)
        constraintsWeightPicker(weightPicker)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 40)])
        
        // Create and add labels to view
        let (nameLabels, valueLabels) = createLabelsInView(self.view)
        
        // Store labels as properties of the view controller
        self.nameLabels = nameLabels
        self.valueLabels = valueLabels
    }
    
    @objc func checkFood(_ sender: UIButton) {
        // Handle button tap event
        
        // Update value labels with random values for testing purposes
        self.valueLabels[0].text = "\(Int.random(in: 100...500))"
        self.valueLabels[1].text = "\(Int.random(in: 10...50)) g"
        self.valueLabels[2].text = "\(Int.random(in: 10...100)) g"
        self.valueLabels[3].text = "\(Int.random(in: 5...30)) g"
    }
}
       

