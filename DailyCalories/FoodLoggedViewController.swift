//
//  FoodLoggedViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 27.02.2023.
//

import UIKit
class FoodLoggedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as? FoodItemTableViewCell else {
            return UITableViewCell()
        }
        cell.configureFoodCell(foods[indexPath.row], tag: indexPath.row)
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
        foodDetailVC.name = foods[indexPath.row]
        let customTransitionDelegate = HalfScreenTransitionDelegate()
        
        foodDetailVC.transitioningDelegate = customTransitionDelegate

        present(foodDetailVC, animated: true, completion: nil)
    }
    
    private var tableView: UITableView!
    private var foods: [String] = ["food1", "food2", "food3", "food4", "food5", "food6", "food7"]
    private var date =  Date()
    var caloriesLabel = UILabel()
    var progressBar = UIProgressView(progressViewStyle: .default)
    var nutrients = ["Proteins", "Carbs", "Fats"]
    var nutrientValues = ["20g", "30g", "15g"]
    var nutrientLabels: [UILabel] = []
    var valueLabels: [UILabel] = []
    
    
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
        
        // Set up constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 450),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        addPieChart()
        addProgressBar()
        addLabels()
        
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
        let selectedDate = sender.date
        self.date = selectedDate
        print("Selected date: \(self.date)")
    }
    
    fileprivate func addPieChart() {
        let chartView = UIView()
        
        var centerPoint = CGPoint(x: 0, y: 0)
        let radius = CGFloat(100) // smaller radius
        let proteinsPercent = Double(180*4/1800.0)
        let fatsPercent = Double(80*9/1800.0)
        let carboPercent = Double(90*4/1800.0)
        
        let sliceData: [(value: Double, color: UIColor, label: String)] = [
            (value: proteinsPercent, color: UIColor.red, label: "\(Int(proteinsPercent*100))% protein"),
            (value: fatsPercent, color: UIColor.blue, label: "\(Int(fatsPercent*100))% fats"),
            (value: carboPercent, color: UIColor.green, label: "\(Int(carboPercent*100))% carbs")
        ]
        
        chartView.frame = CGRect(x: view.frame.width - 200, y: 300, width: 160, height: 160) // new size and position
        view.addSubview(chartView)
        
        centerPoint.x = chartView.bounds.midX
        centerPoint.y = chartView.bounds.midY + 20 // move chart higher
        
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
        for (index, nutrient) in nutrients.enumerated() {
            let nutrientLabel = UILabel()
            nutrientLabel.text = nutrient
            nutrientLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let valueLabel = UILabel()
            valueLabel.text = nutrientValues[index]
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
