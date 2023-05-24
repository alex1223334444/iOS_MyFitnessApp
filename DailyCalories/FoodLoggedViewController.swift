//
//  FoodLoggedViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 27.02.2023.
//

import UIKit
import CoreData
class FoodLoggedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as? FoodItemTableViewCell else {
            return UITableViewCell()
        }
        if let name = foods[indexPath.row].name {
            cell.configureFoodCell(name, calories: Int(foods[indexPath.row].calories), tag: indexPath.row)
        }
        cell.showsReorderControl = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected cell
        guard let cell = tableView.cellForRow(at: indexPath) as? FoodItemTableViewCell else { return }
        
        // Perform the action for the selected cell
        // For example, display more information about the food item
        let selectedFoodItem = cell
        print("Selected food item: \(selectedFoodItem)")
        let foodDetailVC = FoodDetailViewController()
        foodDetailVC.modalPresentationStyle = .custom
        foodDetailVC.name = String(foods[indexPath.row].calories)
        let customTransitionDelegate = HalfScreenTransitionDelegate()
        
        foodDetailVC.transitioningDelegate = customTransitionDelegate

        present(foodDetailVC, animated: true, completion: nil)
    }
    
    private var tableView: UITableView!
    private var foods: [Food] = []
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
        tableView.rowHeight = 80
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
        if calories != 0 {
            addPieChart()
        }
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
        
        if foods.isEmpty {
                chartView?.isHidden = true
            } else {
                if chartView == nil {
                    addPieChart()
                }
                chartView?.isHidden = false
            }
        
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
        print("Selected date: \(self.selectedDate)")
        reloadData()
        if calories == 0 {
            chartView?.removeFromSuperview()
            chartView = nil
        }
    }
    

    fileprivate func addPieChart() {
        // Remove existing chart view if calories is 0
        if calories == 0 {
            chartView?.removeFromSuperview()
            chartView = nil
            return
        }
        
        // Create a new chart view
        chartView = UIView()
        
        guard let chartView = chartView else {
            return
        }
        
        var centerPoint = CGPoint(x: 0, y: 0)
        let radius = CGFloat(100) // smaller radius
        let proteinsPercent = Double(nutrientsValues[0] * 4 / calories)
        let fatsPercent = Double(nutrientsValues[2] * 9 / calories)
        let carboPercent = Double(nutrientsValues[1] * 4 / calories)
        
        let totalPercentage = nutrientsValues.reduce(0, +) / calories // Calculate the total percentage of all nutrients
            
            let sliceData: [(value: Double, color: UIColor, label: String)] = nutrientsValues.enumerated().map { (index, value) in
                let percentage = Double(value / calories) // Calculate the percentage for the current nutrient
                
                let roundedPercentage = (percentage / totalPercentage) * 100 // Round the percentage relative to the total percentage
                
                var label: String
                switch index {
                case 0:
                    label = String(format: "%.2f", roundedPercentage)
                    label.append("% P")
                case 1:
                    label = String(format: "%.2f", roundedPercentage)
                    label.append("% F")
                case 2:
                    label = String(format: "%.2f", roundedPercentage)
                    label.append("% C")
                default:
                    label = ""
                }
                
                return (value: roundedPercentage / 100, color: randomColor(), label: label) // Divide by 100 to convert to a decimal value
            }
        
        chartView.frame = CGRect(x: view.frame.width - 200, y: 300, width: 160, height: 160)
        
        centerPoint.x = chartView.bounds.midX
        centerPoint.y = chartView.bounds.midY + 20
        
        var startAngle = -Double.pi / 2 // Start at the top
        for slice in sliceData {
            let endAngle = startAngle + slice.value * 2 * Double.pi
            let path = UIBezierPath()
            path.move(to: centerPoint)
            path.addArc(withCenter: centerPoint, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
            path.close()
            
            let sliceLayer = CAShapeLayer()
            sliceLayer.path = path.cgPath
            sliceLayer.fillColor = slice.color.cgColor
            chartView.layer.addSublayer(sliceLayer)
            
            let label = UILabel()
            let angle = startAngle + slice.value * Double.pi
            let labelRadius = radius * 0.6
            let labelX = centerPoint.x + labelRadius * CGFloat(cos(angle))
            let labelY = centerPoint.y + labelRadius * CGFloat(sin(angle))
            label.frame = CGRect(x: 0, y: 0, width: 120, height: 20)
            label.center = CGPoint(x: labelX, y: labelY)
            label.textAlignment = .center
            label.text = slice.label
            chartView.addSubview(label)
            
            startAngle = endAngle
        }
        
        // Add the new chart view to the main view
        view.addSubview(chartView)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Remove the view from its superview
        chartView?.removeFromSuperview()
    }

}


class HalfScreenPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let height = containerView.bounds.height / 2
        return CGRect(x: 0, y: containerView.bounds.height - height, width: containerView.bounds.width, height: height)
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }

    override func dismissalTransitionWillBegin() {
        guard let containerView = containerView else { return }
        containerView.backgroundColor = .clear
    }
}

class HalfScreenTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfScreenPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
