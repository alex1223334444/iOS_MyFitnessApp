//
//  RegisterViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 24.09.2022.
//

import UIKit
import FirebaseAuth
import CoreData


class RegisterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TextFieldWithLabelDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    var placeholders = ["First name", "Last name", "E-mail", "Phone number", "Password", "Password confirmation"]
    var registerModel : RegisterModel = RegisterModel()
    var people: [NSManagedObject] = []
    var mailArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.gradientBackground(from: .magenta,to: .orange, direction: .bottomToTop)
        button.layer.cornerRadius = 8
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return placeholders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "textfield", for: indexPath) as? TextfieldTableViewCell else {
            return UITableViewCell()
        }
        cell.configureTextFieldCell(placeholders[indexPath.section], tag: indexPath.section, secure: false, delegate : self)
        cell.showsReorderControl = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func changeText(_ textContent: UITextField?) {
        if let text = textContent?.text, let tag = textContent?.tag {
            switch tag{
            case 0:
                registerModel.firstName = text
            case 1:
                registerModel.lastName = text
            case 2:
                registerModel.email = text
            case 3:
                registerModel.phone = text
            case 4:
                registerModel.password = text
            case 5:
                registerModel.passwordConfirmation = text
            default:
                print()
            }
            
        }
        if registerModel.firstName != "" && registerModel.lastName != "" && registerModel.email != "" && registerModel.phone != "" && registerModel.password != "" && registerModel.passwordConfirmation != ""
        {
            self.button.isEnabled = true
            print(registerModel)
        }
    }
    
    @IBAction func register(_ sender: Any) {
        
        /*Auth.auth().createUser(withEmail: registerModel.email, password: registerModel.password) { [self] (authResult, error) in
         if let error = error {
         let alert = UIAlertController(title: "Error or registering", message: error.localizedDescription, preferredStyle: .alert)
         let ok = UIAlertAction(title: "Ok", style: .default)
         alert.addAction(ok)
         self.present(alert, animated: true, completion: nil)
         
         } else {
         if let firebaseUser = authResult?.user{
         let uid = firebaseUser.uid
         let request : User = User(username: registerModel.email, lastName: registerModel.lastName, uid: uid, phone: registerModel.phone, firstName: registerModel.firstName)
         print(request)
         createUser(user: request) { result in
         switch result {
         case .success(_):
         print("success")
         case .failure(let error):
         print(error)
         }
         }
         }*/
        /*do {
         try Auth.auth().signOut()
         print("user signed out")
         } catch let error {
         print(error.localizedDescription)
         }*/
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        // 1
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
          NSEntityDescription.entity(forEntityName: "User",
                                     in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(registerModel.firstName, forKeyPath: "firstName")
        person.setValue(registerModel.lastName, forKeyPath: "lastName")
        person.setValue(registerModel.email, forKeyPath: "email")
        person.setValue(registerModel.phone, forKeyPath: "phone")
        person.setValue(registerModel.password, forKeyPath: "password")

        
        // 4
        do {
          try managedContext.save()
          people.append(person)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        }
        
}

struct RegisterModel {
    var firstName : String = ""
    var lastName : String = ""
    var email : String = ""
    var phone : String = ""
    var password : String = ""
    var passwordConfirmation : String = ""

}
