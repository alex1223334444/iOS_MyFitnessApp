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
        
        
    }
}
