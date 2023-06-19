//
//  FoodLoggedViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 27.02.2023.
//

import UIKit
import CoreData
import SwiftUI
class FoodLoggedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as? FoodItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        if let name = foods[indexPath.row].name {
            cell.configureFoodCell(name, calories: Int(foods[indexPath.row].calories), tag: indexPath.row)
        }
        
        cell.showsReorderControl = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FoodItemTableViewCell else { return }
        
        let selectedFoodItem = cell
        let foodDetailVC = FoodDetailViewController()
        foodDetailVC.modalPresentationStyle = .automatic
        foodDetailVC.food = foods[indexPath.row]
        present(foodDetailVC, animated: true, completion: nil)
    }
    var hostingController: UIHostingController<BarChart>!
    var tableView: UITableView!
    var foods: [Food] = []
    var caloriesLabel = UILabel()
    var progressBar = UIProgressView(progressViewStyle: .default)
    var nutrients = ["Proteins", "Carbs", "Fats"]
    var nutrientValuesString = ["", "", ""]
    var nutrientsValues = [0.0, 0.0, 0.0]
    var calories = 0.0
    var nutrientLabels: [UILabel] = []
    var valueLabels: [UILabel] = []
    var managedObjectContext: NSManagedObjectContext!
    var email = String()
    var selectedDate = Date()
    fileprivate var chartView: UIView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addHeader(string: "Profile")
        setupDatePicker()
        
        // Initialize and configure the table view
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FoodItemTableViewCell.self, forCellReuseIdentifier: "food")
        self.tableView.tableHeaderView = nil;
        self.tableView.tableFooterView = nil;
        tableView.rowHeight = 100
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.scrollsToTop = false
        tableView.backgroundColor = .systemGray6
        view.addSubview(tableView)
        tableView.reloadData()

        
        // Set up constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 450),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        addBarChart()
        addProgressBar()
        addLabels()
        if let email = UserDefaults.standard.string(forKey: "username") {
            self.email = email
        } else {
            print("email not found")
        }
        
        selectedDate = Date()

        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
                let user = fetchUser()
        
        if let foods = user?.foods {
            for food in foods {
                if let foodObject = food as? Food {
                    let foodDateComponents = calendar.dateComponents([.year, .month, .day], from: foodObject.time)
                    
                    if currentComponents.year == foodDateComponents.year &&
                       currentComponents.month == foodDateComponents.month &&
                       currentComponents.day == foodDateComponents.day {
                        //print(foodObject.name)
                        print(foodObject.time)
                        self.foods.append(foodObject)
                        
                    }
                
                }
            }
        }

    }
    
    
    
    fileprivate func reloadData() {
        let user = fetchUser()
        self.foods = []
        
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        var proteins = 0.0
        var carbs = 0.0
        var fats = 0.0
        var calories = 0.0
        
        if let foods = user?.foods {
            for food in foods {
                if let foodObject = food as? Food {
                    let foodDateComponents = calendar.dateComponents([.year, .month, .day], from: foodObject.time)
                    
                    if currentComponents.year == foodDateComponents.year &&
                        currentComponents.month == foodDateComponents.month &&
                        currentComponents.day == foodDateComponents.day {
                        
                        self.foods.append(foodObject)
                        proteins += foodObject.protein
                        calories += foodObject.calories
                        carbs += foodObject.carbohydrates
                        fats += foodObject.fat
                    }
                }
            }
        }
        
        self.calories = calories // Update the calories value
        
        nutrientValuesString[0] = "\(String(format: "%.2f", proteins))g"
        nutrientValuesString[1] = "\(String(format: "%.2f", carbs))g"
        nutrientValuesString[2] = "\(String(format: "%.2f", fats))g"
        nutrientsValues[0] = proteins
        nutrientsValues[1] = carbs
        nutrientsValues[2] = fats
        
        addLabels()
        caloriesLabel.text = "\(calories)/2000"
        addBarChart()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    private func setupDatePicker() {
        // Initialize the date picker
        let datePicker = UIDatePicker()
        
        let label = UILabel(frame: CGRect(x: 10, y: 190, width: 200, height: 20))
        label.text = "Select the desired date:"
        view.addSubview(label)
        // Set the desired mode for the date picker
        datePicker.datePickerMode = .date
        
        // Optional: set the date picker's locale to support different languages and regions
        datePicker.locale = Locale(identifier: "en_US")
        
        // Set the date picker's frame, position it as needed
        datePicker.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 200)
        
        // Optional: configure additional properties, such as minimum and maximum dates
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 10, to: Date())
        
        // Add the date picker to the view controller's view
        view.addSubview(datePicker)
        
        // Optional: handle the date picker's value changes by adding a target to the valueChanged event
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
        chartView?.removeFromSuperview()
        chartView = nil
        reloadData()
    }
    
    
    fileprivate func addBarChart() {
        hostingController?.willMove(toParent: nil)
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()
        if calories != 0 {
            let customSwiftUIView = BarChart(proteins: nutrientsValues[0], carbs: nutrientsValues[1], fats: nutrientsValues[2])
            hostingController = UIHostingController(rootView: customSwiftUIView)
            if let hostingController = hostingController {
                addChild(hostingController)
                view.addSubview(hostingController.view)
                
                hostingController.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
                    hostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 75),
                    hostingController.view.heightAnchor.constraint(equalToConstant: 200),
                    hostingController.view.widthAnchor.constraint(equalToConstant: 200)
                ])
                
                hostingController.didMove(toParent: self)
            }
        }
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    fileprivate func addProgressBar() {
        caloriesLabel.text = "Calories: 1000/2000"
        caloriesLabel.textAlignment = .center
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create the progress view (progress bar)
        progressBar.setProgress(0.5, animated: false) // Set the initial progress (0 to 1)
        progressBar.trackTintColor = .lightGray
        progressBar.progressTintColor = .systemGreen
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Add label and progress bar to the main view
        view.addSubview(caloriesLabel)
        view.addSubview(progressBar)
        
        // Set constraints for the label
        NSLayoutConstraint.activate([
            caloriesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            caloriesLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 250)
        ])
        
        // Set constraints for the progress bar
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            progressBar.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 10),
            progressBar.heightAnchor.constraint(equalToConstant: 10) // Set the height of the progress bar
        ])
    }
    
    fileprivate func addLabels() {
        // Remove existing nutrient labels and value labels from the superview
        for nutrientLabel in nutrientLabels {
            nutrientLabel.removeFromSuperview()
        }
        for valueLabel in valueLabels {
            valueLabel.removeFromSuperview()
        }
        
        // Clear the nutrientLabels and valueLabels arrays
        nutrientLabels.removeAll()
        valueLabels.removeAll()
        
        for (index, nutrient) in nutrients.enumerated() {
            let nutrientLabel = UILabel()
            nutrientLabel.text = nutrient
            nutrientLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let valueLabel = UILabel()
            valueLabel.text = nutrientValuesString[index]
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            
            nutrientLabels.append(nutrientLabel)
            valueLabels.append(valueLabel)
            
            view.addSubview(nutrientLabel)
            view.addSubview(valueLabel)
        }
        
        // Set constraints for nutrient labels and value labels
        for i in 0..<nutrientLabels.count {
            let topAnchor = i == 0 ? progressBar.bottomAnchor : nutrientLabels[i - 1].bottomAnchor
            
            NSLayoutConstraint.activate([
                nutrientLabels[i].topAnchor.constraint(equalTo: topAnchor, constant: 40),
                nutrientLabels[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                valueLabels[i].leadingAnchor.constraint(equalTo: nutrientLabels[i].trailingAnchor, constant: 5),
                valueLabels[i].centerYAnchor.constraint(equalTo: nutrientLabels[i].centerYAnchor)
            ])
        }
    }
    
    func fetchUser() -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        // Create a predicate to match the UUID
        let uuidPredicate = NSPredicate(format: "email == %@", self.email)
        fetchRequest.predicate = uuidPredicate
        
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
    

}




extension FoodLoggedViewController: FoodItemTableViewCellDelegate {
    func deleteButtonTapped(for cell: FoodItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        // Delete the selected food item
        let foodItem = foods[indexPath.row]
        managedObjectContext.delete(foodItem)
        
        // Save the changes
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to delete food item: \(error)")
        }
        
        // Remove the deleted item from the foods array and reload the table view
        foods.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // Update the nutrient labels and reload data
        reloadData()
    }
}
