//
//  HomeViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 27.02.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var addFoodButton: UIImageView!

    @IBOutlet weak var infoButton: UIButton!
    
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
        let chartView = UIView()

        var centerPoint = CGPoint(x: 0, y: 0)
        let radius = CGFloat(120)
        var proteinsPercent = Double(180*4/1800.0)
        var fatsPercent = Double(80*9/1800.0)
        var carboPercent = Double(90*4/1800.0)

        let sliceData: [(value: Double, color: UIColor, label: String)] = [
            (value: proteinsPercent, color: UIColor.red, label: "\(Int(proteinsPercent*100))% protein"),
            (value: fatsPercent, color: UIColor.blue, label: "\(Int(fatsPercent*100))% fats"),
            (value: carboPercent, color: UIColor.green, label: "\(Int(carboPercent*100))% carbs")
        ]

        chartView.frame = CGRect(x: 0, y: 0, width: 2 * radius, height: 2 * radius)
        chartView.center = view.center
        view.addSubview(chartView)

        centerPoint.x = chartView.bounds.midX
        centerPoint.y = chartView.bounds.midY + 100

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
    
    @IBAction func addFood(_ sender: Any) {
        let nextVC = AddFoodViewController()
        navigationController?.present(nextVC, animated: true)
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
     
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/
    

}
