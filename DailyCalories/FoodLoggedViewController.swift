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
    private var tableView: UITableView!
    private var foods: [String] = ["food1", "food2", "food3", "food4", "food5", "food6", "food7"]
    private var date =  Date()
    
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

        // Set table header and footer background colors to transparent
        /*tableView.tableHeaderView?.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 0.01))
        tableView.tableFooterView?.backgroundColor = UIColor.clear*/

        // Set up constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        addPieChart()
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
        
        chartView.frame = CGRect(x: view.frame.width - 200, y: 280, width: 160, height: 160) // new size and position
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
    
}
