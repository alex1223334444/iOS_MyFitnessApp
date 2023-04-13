//
//  HomeViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 27.02.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var addFoodButton: UIImageView!

    
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
        print("da")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
