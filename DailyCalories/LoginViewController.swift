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
         
        /*let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject]{
                if let mail = result.value(forKey: "email") as? String{
                    self.mailArray.append(mail)
                }
                if let password = result.value(forKey: "password") as? String{
                    self.passwordArray.append(password)
                }
                
            }
        }
        catch{
            print("error")
        }
        
        if (mailArray.contains(user.username)){
            let mailIndex = mailArray.firstIndex(where: {$0 == user.username})
            
            if passwordArray[mailIndex!] == user.password{
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.set(user.password, forKey: "password")

                self.performSegue(withIdentifier: "login", sender: nil)
            }
        }
        else{
            // create the alert
            let alert = UIAlertController(title: "Not Found", message: "No account found for this e-mail address", preferredStyle: .alert)
            // add an action (button)
            //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
            }
            alert.addAction(okAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }*/
        
    }
}

struct UserModel {
    var username : String = ""
    var password : String = ""
}
