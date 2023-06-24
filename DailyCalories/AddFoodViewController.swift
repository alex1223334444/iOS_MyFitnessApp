//
//  AddFoodViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 19.04.2023.
//

import UIKit
import CoreData
import Firebase

class AddFoodViewController: UIViewController, TextFieldWithLabelDelegate {
    func changeText(_ textContent: UITextField?) {
        if textContent?.tag == 1 {
            food = textContent?.text ?? ""
            print(food)
        }
        else {
            quantity = Int(textContent?.text ?? "") ?? 0
            print(quantity)
        }
    }
    
    var nameLabels = [UILabel]()
    var valueLabels = [UILabel]()
    var food = ""
    var quantity = 0
    var weightPicker = WeightPicker()
    var name = ""
    var calories = 0.0
    var servingSize = 0.0
    var fatTotal = 0.0
    var fatSaturated = 0.0
    var protein = 0.0
    var sodium = 0.0
    var potassium = 0.0
    var cholesterol = 0.0
    var carbsTotal = 0.0
    var fiber = 0.0
    var sugar = 0.0
    var managedObjectContext: NSManagedObjectContext!
    var email = String()
    
    fileprivate func constraintsFoodTextfield(_ foodText: Textfield) {
        NSLayoutConstraint.activate([
            foodText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            foodText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            foodText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -70),
            foodText.heightAnchor.constraint(equalToConstant: 50)
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
        let kcal = UILabel()
        kcal.text = "Calories:"
        let proteins = UILabel()
        proteins.text = "Proteins:"
        let carbs = UILabel()
        carbs.text = "Carbohydrates:"
        let fats = UILabel()
        fats.text = "Fats:"
        
        view.addSubview(kcal)
        view.addSubview(proteins)
        view.addSubview(carbs)
        view.addSubview(fats)
        
        kcal.translatesAutoresizingMaskIntoConstraints = false
        proteins.translatesAutoresizingMaskIntoConstraints = false
        carbs.translatesAutoresizingMaskIntoConstraints = false
        fats.translatesAutoresizingMaskIntoConstraints = false
        let margin: CGFloat = 20
        NSLayoutConstraint.activate([
            kcal.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            kcal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            
            proteins.leadingAnchor.constraint(equalTo: kcal.leadingAnchor),
            proteins.topAnchor.constraint(equalTo: kcal.bottomAnchor, constant: margin),
            
            carbs.leadingAnchor.constraint(equalTo: kcal.leadingAnchor),
            carbs.topAnchor.constraint(equalTo: proteins.bottomAnchor, constant: margin),
            
            fats.leadingAnchor.constraint(equalTo: kcal.leadingAnchor),
            fats.topAnchor.constraint(equalTo: carbs.bottomAnchor, constant: margin),
        ])
        
        let heightConstraints = [
            fats.heightAnchor.constraint(equalToConstant: 20),
            kcal.heightAnchor.constraint(equalTo: proteins.heightAnchor),
            proteins.heightAnchor.constraint(equalTo: carbs.heightAnchor),
            carbs.heightAnchor.constraint(equalTo: fats.heightAnchor)
        ]
        NSLayoutConstraint.activate(heightConstraints)
        
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
        
        view.addSubview(kcalValue)
        view.addSubview(proteinsValue)
        view.addSubview(carbsValue)
        view.addSubview(fatsValue)
        
        kcalValue.translatesAutoresizingMaskIntoConstraints = false
        proteinsValue.translatesAutoresizingMaskIntoConstraints = false
        carbsValue.translatesAutoresizingMaskIntoConstraints = false
        fatsValue.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            kcalValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            kcalValue.topAnchor.constraint(equalTo: kcal.topAnchor),
            
            proteinsValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            proteinsValue.topAnchor.constraint(equalTo: proteins.topAnchor),
            
            carbsValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            carbsValue.topAnchor.constraint(equalTo: carbs.topAnchor),
            
            fatsValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            fatsValue.topAnchor.constraint(equalTo: fats.topAnchor)
        ])
        
        let valueHeightConstraints = [kcalValue.heightAnchor.constraint(equalTo: proteinsValue.heightAnchor),        proteinsValue.heightAnchor.constraint(equalTo: carbsValue.heightAnchor),        carbsValue.heightAnchor.constraint(equalTo: fatsValue.heightAnchor)]
        NSLayoutConstraint.activate(valueHeightConstraints)
        
        return ([kcal, proteins, carbs, fats], [kcalValue, proteinsValue, carbsValue, fatsValue])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        self.hideKeyboardWhenTappedAround()
        
        let foodText = Textfield()
        foodText.configureTextField(with: "Name the food", tag: 1, delegate: self, image: nil)
        foodText.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(foodText)
        
        let quantityText = Textfield()
        quantityText.configureTextField(with: "How much?", tag: 2, delegate: self, image: nil)
        quantityText.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(quantityText)
        
        weightPicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(weightPicker)
        
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 10
        button.setTitle("Check food", for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.7)
        button.addTarget(self, action: #selector(checkFood(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        constraintsFoodTextfield(foodText)
        constraintsQuantityTextfield(quantityText)
        constraintsWeightPicker(weightPicker)
        
        let buttonSave = UIButton(type: .roundedRect)
        buttonSave.layer.cornerRadius = 10
        buttonSave.setTitle("Save food", for: .normal)
        buttonSave.backgroundColor = .systemGreen.withAlphaComponent(0.7)
        buttonSave.addTarget(self, action: #selector(saveFood(_:)), for: .touchUpInside)
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonSave)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 40),
            buttonSave.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonSave.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonSave.widthAnchor.constraint(equalToConstant: 100),
            buttonSave.heightAnchor.constraint(equalToConstant: 40)])
        let (nameLabels, valueLabels) = createLabelsInView(self.view)
        
        self.nameLabels = nameLabels
        self.valueLabels = valueLabels
        
        if let email = UserDefaults.standard.string(forKey: "username") {
            self.email = email
        } else {
            print("email not found")
        }
        
        let user = fetchUser()
        
    }
    
    @objc func checkFood(_ sender: UIButton) {
        
        let text = "\(quantity) \(weightPicker.selectedUnit) of \(food)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query="+text!)!
        var request = URLRequest(url: url)
        request.setValue("jWhNwKEikKQQYZPwOq6gkA==EcFrD0XB6Fe8uZ2A", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let firstItem = json.first {
                    
                    let name = firstItem["name"] as? String ?? ""
                    let calories = firstItem["calories"] as? Double ?? 0.0
                    let servingSize = firstItem["serving_size_g"] as? Double ?? 0.0
                    let fatTotal = firstItem["fat_total_g"] as? Double ?? 0.0
                    let fatSaturated = firstItem["fat_saturated_g"] as? Double ?? 0.0
                    let protein = firstItem["protein_g"] as? Double ?? 0.0
                    let sodium = firstItem["sodium_mg"] as? Int ?? 0
                    let potassium = firstItem["potassium_mg"] as? Int ?? 0
                    let cholesterol = firstItem["cholesterol_mg"] as? Int ?? 0
                    let carbsTotal = firstItem["carbohydrates_total_g"] as? Double ?? 0.0
                    let fiber = firstItem["fiber_g"] as? Double ?? 0.0
                    let sugar = firstItem["sugar_g"] as? Double ?? 0.0
                    
                    let foodItem = FoodRequested(name: name, calories: calories, serving_size_g: servingSize, fat_total_g: fatTotal, fat_saturated_g: fatSaturated, protein_g: protein, sodium_mg: Double(sodium), potassium_mg: Double(potassium), cholesterol_mg: Double(cholesterol), carbohydrates_total_g: carbsTotal, fiber_g: fiber, sugar_g: sugar)
                    DispatchQueue.main.async {
                        self.valueLabels[0].text = "\(String(describing: foodItem.calories) )"
                        self.valueLabels[1].text = "\(String(describing: foodItem.protein_g)) g"
                        self.valueLabels[2].text = "\(String(describing: foodItem.carbohydrates_total_g)) g"
                        self.valueLabels[3].text = "\(String(describing: foodItem.fat_total_g)) g"
                        self.calories = foodItem.calories
                        self.servingSize = foodItem.serving_size_g
                        self.fatTotal = foodItem.fat_total_g
                        self.fatSaturated = foodItem.fat_saturated_g
                        self.protein = foodItem.protein_g
                        self.sodium = foodItem.sodium_mg
                        self.potassium = foodItem.potassium_mg
                        self.cholesterol = foodItem.cholesterol_mg
                        self.carbsTotal = foodItem.carbohydrates_total_g
                        self.fiber = foodItem.fiber_g
                        self.sugar = foodItem.sugar_g
                    }
                }
            } catch {
                print("Error parsing JSON data: \(error.localizedDescription)")
            }
        }
        task.resume()
        
    }
    
    @objc func saveFood(_ sender: UIButton) {
        let food = Food(context: managedObjectContext)
        food.name = self.food
        food.calories = self.calories
        food.sugar = self.sugar
        food.fiber = self.fiber
        food.potassium = self.potassium
        food.sodium = self.sodium
        food.protein = self.protein
        food.servingSize = self.servingSize
        food.carbohydrates = self.carbsTotal
        food.fat = self.fatTotal
        food.saturatedFat = self.fatSaturated
        food.time = Date.now
        
        print(food)
        
        let user = fetchUser()
        user?.addToFoods(food)
        do {
            try managedObjectContext.save()
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("error at adding food")
        }
        
    }
    
    
    func fetchUser() -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        let mailPredicate = NSPredicate(format: "email == %@", self.email)
        fetchRequest.predicate = mailPredicate
        
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
}


       

