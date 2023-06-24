//
//  LoginViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 24.09.2022.
//

import UIKit
import FirebaseAuth
import CoreData

class LoginViewController: UIViewController , TextFieldWithLabelDelegate {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var usernameTextfield: Textfield!
    @IBOutlet weak var passwordTextfield: Textfield!
    @IBOutlet weak var registerLink: UIButton!
    @IBOutlet weak var facebookSignIn: UIButton!
    @IBOutlet weak var appleSignIn: UIButton!
    @IBOutlet weak var googleSignIn: UIButton!
    @IBOutlet weak var logo: UIImageView!
    private var user : UserModel = UserModel()
    var mailArray = [String]()
    var passwordArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextfield.configureTextField(with: "Username", secured: false, tag: 0, delegate: self, image: "apple")
        passwordTextfield.configureTextField(with: "Password", secured: true, tag: 1, delegate: self, image: "apple")
        self.navigationItem.hidesBackButton = true
        facebookSignIn.layer.cornerRadius = 10
        googleSignIn.layer.cornerRadius = 10
        appleSignIn.layer.cornerRadius = 10
        self.hideKeyboardWhenTappedAround()
        button.layer.cornerRadius = 8
        button.isEnabled = false
        logo.layer.cornerRadius = 15
        self.button.backgroundColor = .gray

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
                button.backgroundColor = .systemBlue
            }
            else {
                button.isEnabled = false
                button.backgroundColor = .gray
            }
        }
    }
    @IBAction func login(_ sender: Any) {
        
         Auth.auth().signIn(withEmail: user.username, password: user.password) { [weak self] result, error in
         if let result = result {
             let alert = UIAlertController(title: "User successfully logged in", message: result.description, preferredStyle: .alert)
         let ok = UIAlertAction(title: "Ok", style: .default) {_ in
         UserDefaults.standard.set(self?.user.username, forKey: "username")
         UserDefaults.standard.set(result.user.uid, forKey: "uid")
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
