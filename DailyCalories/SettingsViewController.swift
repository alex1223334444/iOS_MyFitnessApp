//
//  SettingsViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 29.11.2022.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController, TextFieldWithLabelDelegate {
    func changeText(_ textContent: UITextField?) {
        if let text = textContent?.text
        {
            food = text
        }
    }
    
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var food : String?
    //var requestedFood : [Food]? = []
    //var userFood : [Food] = []
    private var uid = ""
    @IBAction func submit(_ sender: Any) {
        let query = "1 kg of chicken breast with fries".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query="+query!)!
        var request = URLRequest(url: url)
        request.setValue("jWhNwKEikKQQYZPwOq6gkA==EcFrD0XB6Fe8uZ2A", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
         guard let data = data else { return }
         print(String(data: data, encoding: .utf8)!)
         }
         task.resume()
        /*URLSession.shared.dataTask(with: request) { [self] data, response, error in
            let foods = try! JSONDecoder().decode([FoodRequested].self, from: data!)
            //print(foods)
            for i in 0..<foods.count{
                let myFood = Food(uid: uid, name: foods[i].name, calories: foods[i].calories,serving_size_g: foods[i].serving_size_g, fat_total_g: foods[i].fat_total_g, fat_saturated_g: foods[i].fat_saturated_g, protein_g: foods[i].protein_g, sodium_mg: foods[i].sodium_mg, potassium_mg: foods[i].potassium_mg, cholesterol_mg: foods[i].cholesterol_mg, carbohydrates_total_g: foods[i].carbohydrates_total_g, fiber_g: foods[i].fiber_g, sugar_g: foods[i].sugar_g)
                print(myFood)
                requestedFood?.append(myFood)
                addFood(food: myFood, completion: { result in
                    switch result {
                    case .success(_):
                        print("success")
                    case .failure(let error):
                        print(error)
                    }
                })
            }
            
            print(self.requestedFood as Any)
        }.resume()
        */
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*self.view.gradientBackground(from: .magenta,to: .orange, direction: .bottomToTop)
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        self.submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        self.submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        self.submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true*/
        // Do any additional setup after loading the view.
    }
    
    
    
   /* override func viewWillAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
            let id = user.uid
            uid = id
            print(id)
            getFoods(forUserWithId: uid) { (foods, error) in
                if let error = error {
                    // Handle the error
                    print(error)
                    return
                }

                if let foods = foods {
                    self.userFood = foods
                    print(self.userFood)
                }
            }
        } else {
            //
        }
        
        
    }
    */
    
}
