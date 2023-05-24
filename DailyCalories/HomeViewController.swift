//
//  HomeViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 27.02.2023.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var addFoodButton: UIImageView!

    @IBOutlet weak var infoButton: UIButton!
    private var calories = 0.0
    private var nutrientValuesString = ["", "", ""]
    private var nutrientsValues = [0.0, 0.0, 0.0]
    private var foods: [Food] = []
    private var managedObjectContext: NSManagedObjectContext!
    private var email = String()
    private var chartView : UIView?
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addHeader(string: "Home")
        /*let query = "100g chicken shawarma".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query="+query!)!
        var request = URLRequest(url: url)
        request.setValue("jWhNwKEikKQQYZPwOq6gkA==EcFrD0XB6Fe8uZ2A", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
         guard let data = data else { return }
         print(String(data: data, encoding: .utf8)!)
         }
         task.resume()*/
        if let email = UserDefaults.standard.string(forKey: "username") {
            self.email = email
        } else {
            print("email not found")
        }
        managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let todayDate = Date.now
        let user = fetchUser()
        self.foods = []
        
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.year, .month, .day], from: todayDate)
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
        addPieChart()
        
    }
    
    @IBAction func addFood(_ sender: Any) {
        let nextVC = AddFoodViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
     @IBAction func showAdditionalInfo(_ sender: Any) {
         let alertController = UIAlertController(title: "Macronutrient Details", message: nil, preferredStyle: .alert)

         let caloriesLabel = UILabel()
         let calories = 2000
         caloriesLabel.text = "Calories: \(calories) kcal"
         caloriesLabel.textColor = .black
         alertController.view.addSubview(caloriesLabel)
         caloriesLabel.translatesAutoresizingMaskIntoConstraints = false // enable constraints

         let proteinLabel = UILabel()
         proteinLabel.text = "Protein: 23.7 g"
         proteinLabel.textColor = .black
         alertController.view.addSubview(proteinLabel)
         proteinLabel.translatesAutoresizingMaskIntoConstraints = false // enable constraints

         let carbohydratesLabel = UILabel()
         let carbohydrates = 0.0
         carbohydratesLabel.text = "Carbohydrates: \(carbohydrates) g"
         carbohydratesLabel.textColor = .black
         alertController.view.addSubview(carbohydratesLabel)
         carbohydratesLabel.translatesAutoresizingMaskIntoConstraints = false // enable constraints

         let fatLabel = UILabel()
         let fat = 12.9
         fatLabel.text = "Fat: \(fat) g"
         fatLabel.textColor = .black
         alertController.view.addSubview(fatLabel)
         fatLabel.translatesAutoresizingMaskIntoConstraints = false // enable constraints

         let saturatedFatLabel = UILabel()
         let saturatedFat = 3.7
         saturatedFatLabel.text = "Saturated Fat: \(saturatedFat) g"
         saturatedFatLabel.textColor = .black
         alertController.view.addSubview(saturatedFatLabel)
         saturatedFatLabel.translatesAutoresizingMaskIntoConstraints = false // enable constraints

         let fiberLabel = UILabel()
         let fiber = 0.0
         fiberLabel.text = "Fiber: \(fiber) g"
         fiberLabel.textColor = .black
         alertController.view.addSubview(fiberLabel)
         fiberLabel.translatesAutoresizingMaskIntoConstraints = false // enable constraints

         let sugarLabel = UILabel()
         let sugar = 0.0
         sugarLabel.text = "Sugar: \(sugar) g"
         sugarLabel.textColor = .black
         alertController.view.addSubview(sugarLabel)
         sugarLabel.translatesAutoresizingMaskIntoConstraints = false // enable constraints

         let sodiumLabel = UILabel()
         let sodium = 72
         sodiumLabel.text = "Sodium: \(sodium) mg"
         sodiumLabel.textColor = .black
         alertController.view.addSubview(sodiumLabel)
         sodiumLabel.translatesAutoresizingMaskIntoConstraints = false // enable constraints

         let potassiumLabel = UILabel()
         let potassium = 179
         potassiumLabel.text = "Potassium: \(potassium) mg"
         potassiumLabel.textColor = .black
         alertController.view.addSubview(potassiumLabel)
         potassiumLabel.translatesAutoresizingMaskIntoConstraints = false // enable constraints

         let cholesterolLabel = UILabel()
         let cholesterol = 92
         cholesterolLabel.text = "Cholesterol: \(cholesterol) mg"
         cholesterolLabel.textColor = .black
         alertController.view.addSubview(cholesterolLabel)
         cholesterolLabel.translatesAutoresizingMaskIntoConstraints = false // enable constraints

         // add constraints to position the labels
         NSLayoutConstraint.activate([
             caloriesLabel.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 50),
             caloriesLabel.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
             proteinLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 10),
             proteinLabel.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
             carbohydratesLabel.topAnchor.constraint(equalTo: proteinLabel.bottomAnchor, constant: 10),
             carbohydratesLabel.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
             fatLabel.topAnchor.constraint(equalTo: carbohydratesLabel.bottomAnchor, constant: 10),
             fatLabel.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
             saturatedFatLabel.topAnchor.constraint(equalTo: fatLabel.bottomAnchor, constant: 10),
             saturatedFatLabel.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
             fiberLabel.topAnchor.constraint(equalTo: saturatedFatLabel.bottomAnchor, constant: 10),
             fiberLabel.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
             sugarLabel.topAnchor.constraint(equalTo: fiberLabel.bottomAnchor, constant: 10),
             sugarLabel.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
             sodiumLabel.topAnchor.constraint(equalTo: sugarLabel.bottomAnchor, constant: 10),
             sodiumLabel.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
             potassiumLabel.topAnchor.constraint(equalTo: sodiumLabel.bottomAnchor, constant: 10),
             potassiumLabel.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
             cholesterolLabel.topAnchor.constraint(equalTo: potassiumLabel.bottomAnchor, constant: 10),
             cholesterolLabel.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 20),
             ])

             let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
             alertController.addAction(okAction)
             let widthConstraint = NSLayoutConstraint(item: alertController.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
             let heightConstraint = NSLayoutConstraint(item: alertController.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400)
             alertController.view.addConstraints([widthConstraint, heightConstraint])

             self.present(alertController, animated: true, completion: nil)
         
         
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
    
    override func viewWillAppear(_ animated: Bool) {
        foods = []
        if let email = UserDefaults.standard.string(forKey: "username") {
            self.email = email
        } else {
            print("email not found")
        }
        let todayDate = Date.now
        var proteins = 0.0
        var carbs = 0.0
        var fats = 0.0
        var calories = 0.0
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.year, .month, .day], from: todayDate)
        managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
                let user = fetchUser()
        
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
        reloadData()
        
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
        
        let chartSize: CGFloat = 400
        let chartOriginX = (view.frame.width - chartSize) / 2 + 200
        let chartOriginY = (view.frame.height - chartSize) / 2 + 300
        chartView.frame = CGRect(x: chartOriginX, y: chartOriginY, width: chartSize, height: chartSize)

        print("x:\(chartOriginX)")
        print("y:\(chartOriginY)")

        chartView.frame = CGRect(x: chartOriginX, y: chartOriginY, width: chartSize, height: chartSize)

        
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
        view.bringSubviewToFront(addButton)
    }
    
    func reloadData() {
        addPieChart()
        caloriesLabel.text = "Total of calories consumed: \(calories)/2000"
        proteinLabel.text = nutrientValuesString[0]
        carbsLabel.text = nutrientValuesString[1]
        fatsLabel.text = nutrientValuesString[2]
        progressBar.progress = Float(calories/2000)
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    

}
