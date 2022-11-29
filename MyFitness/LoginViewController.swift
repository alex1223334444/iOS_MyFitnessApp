//
//  LoginViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 24.09.2022.
//

import UIKit

class LoginViewController: UIViewController , TextFieldWithLabelDelegate, ButtonDelegate{
    
    @IBOutlet weak var button: Button!
    @IBOutlet weak var usernameTextfield: Textfield!
    @IBOutlet weak var passwordTextfield: Textfield!
    @IBOutlet weak var registerLink: UIButton!
    @IBOutlet weak var facebookSignIn: UIButton!
    @IBOutlet weak var appleSignIn: UIButton!
    @IBOutlet weak var googleSignIn: UIButton!
    private var user : UserModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextfield.configureTextField(with: "Username", secured: false, tag: 0, delegate: self)
        passwordTextfield.configureTextField(with: "Password", secured: true, tag: 1, delegate: self)
        button.configureButton(title: "Submit", delegate: self)
        self.navigationItem.hidesBackButton = true
        facebookSignIn.layer.cornerRadius = facebookSignIn.frame.width/2
        googleSignIn.layer.cornerRadius = googleSignIn.frame.width/2
        appleSignIn.layer.cornerRadius = appleSignIn.frame.width/2
        self.hideKeyboardWhenTappedAround()
    }
    
    
    
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
}

struct UserModel {
    var username : String = ""
    var password : String = ""
}
