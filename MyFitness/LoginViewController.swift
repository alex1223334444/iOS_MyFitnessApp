//
//  LoginViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 24.09.2022.
//

import UIKit

class LoginViewController: UIViewController , TextFieldWithLabelDelegate, ButtonDelegate{
    func buttonTouchUpInside() {
        print(user)
    }
    
    func changeText(_ textContent: UITextField?) {
        if let text = textContent?.text, let getTag = textContent?.tag {
            if getTag == 0 {
                user.username = text
            }
            else {
                user.password = text
            }
            if user.password != "" && user.username != ""{
                button.enable(enabled: true)
            }
        }
    }
    
    
    @IBOutlet weak var button: Button!
    @IBOutlet weak var usernameTextfield: Textfield!
    @IBOutlet weak var passwordTextfield: Textfield!
    private var user : UserModel = UserModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextfield.configureTextField(with: "Username", secured: false, tag: 0, delegate: self)
        passwordTextfield.configureTextField(with: "Password", secured: true, tag: 1, delegate: self)
        button.configureButton(title: "Submit", delegate: self)
        // Do any additional setup after loading the view.
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

struct UserModel {
    var username : String = ""
    var password : String = ""
}
