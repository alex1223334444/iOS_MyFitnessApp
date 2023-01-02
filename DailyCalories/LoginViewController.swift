//
//  LoginViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 24.09.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController , TextFieldWithLabelDelegate {
    
    @IBOutlet weak var button: UIButton!
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
        self.navigationItem.hidesBackButton = true
        facebookSignIn.layer.cornerRadius = 10
        googleSignIn.layer.cornerRadius = 10
        appleSignIn.layer.cornerRadius = 10
        self.hideKeyboardWhenTappedAround()
        button.layer.cornerRadius = 8
        button.isEnabled = false
        self.view.gradientBackground(from: .magenta, to: .orange, direction: .bottomToTop)
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
                button.isEnabled = true
            }
            else {
                button.isEnabled = false
            }
        }
    }
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: user.username, password: user.password) { [weak self] user, error in
            if let user = user {
                let alert = UIAlertController(title: "User successfully logged in", message: user.description, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default) {_ in
                    self?.performSegue(withIdentifier: "login", sender: nil)
                }
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
            }
            else if let error = error {
                let alert = UIAlertController(title: "Error on login", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
            }
          
        }
    }
}

struct UserModel {
    var username : String = ""
    var password : String = ""
}
