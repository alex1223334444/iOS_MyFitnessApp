//
//  ProfileViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 20.02.2023.
//

import UIKit
import CoreData
import FirebaseAuth
import StoreKit

class ProfileViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addHeader()
        addGoalButton()
        addLogoutButton()
        addRatingButton()
        addDeleteButton()
        addChangePasswordButton()
        if let email = UserDefaults.standard.string(forKey: "username") {
            self.email = email
        } else {
            print("email not found")
        }
        managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        addProfile()
        
    }
    
    fileprivate func addDeleteButton() {
        let deleteButton = UIButton(type: .roundedRect)
        deleteButton.backgroundColor = .systemRed
        deleteButton.layer.cornerRadius = 10
        self.view.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 240),
            deleteButton.heightAnchor.constraint(equalToConstant: 50),
            deleteButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        deleteButton.setTitle("Delete account", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.addTarget(self, action:#selector(self.deleteAccount), for: .touchUpInside)
    }
    
    fileprivate func addLogoutButton() {
        let logoutButton = UIButton(type: .roundedRect)
        logoutButton.backgroundColor = .systemGreen
        logoutButton.layer.cornerRadius = 10
        self.view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.addTarget(self, action:#selector(self.logout), for: .touchUpInside)
    }
    
    fileprivate func addProfile() {
        let pictureView = UIImageView(image:  UIImage(systemName: "person.circle.fill"))
        pictureView.contentMode = .scaleAspectFill
        pictureView.tintColor = .systemGreen
        pictureView.clipsToBounds = true
        pictureView.layer.cornerRadius = 50
        view.addSubview(pictureView)
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        
        let user = fetchUser()
        let name = UILabel()
        if let firstName = user?.firstName, let lastName = user?.lastName {
            name.text = "\(firstName) \(lastName)"
        }
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
        
        let emailLabel = UILabel()
        emailLabel.text = email
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            pictureView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            pictureView.heightAnchor.constraint(equalToConstant: 100),
            pictureView.widthAnchor.constraint(equalToConstant: 100),
            name.leadingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: 20),
            name.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            emailLabel.leadingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: 20),
            emailLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10)
        ])
    }
    
    fileprivate func addRatingButton() {
        let goalButton = UIButton(type: .roundedRect)
        goalButton.backgroundColor = .systemGreen
        goalButton.layer.cornerRadius = 10
        self.view.addSubview(goalButton)
        goalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 160),
            goalButton.heightAnchor.constraint(equalToConstant: 50),
            goalButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        goalButton.setTitle("Rate us", for: .normal)
        goalButton.setTitleColor(.black, for: .normal)
        goalButton.addTarget(self, action:#selector(self.addRating), for: .touchUpInside)
    }
    
    fileprivate func addChangePasswordButton() {
        let changePassword = UIButton(type: .roundedRect)
        changePassword.backgroundColor = .systemGreen
        changePassword.layer.cornerRadius = 10
        self.view.addSubview(changePassword)
        changePassword.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changePassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changePassword.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            changePassword.heightAnchor.constraint(equalToConstant: 50),
            changePassword.widthAnchor.constraint(equalToConstant: 200)
        ])
        changePassword.setTitle("Change your password", for: .normal)
        changePassword.setTitleColor(.black, for: .normal)
        changePassword.addTarget(self, action:#selector(self.changePassword), for: .touchUpInside)
    }
    
    fileprivate func addGoalButton() {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
        button.setTitle("Set calories goal", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action:#selector(self.setCalories), for: .touchUpInside)
    }
    
    fileprivate func logoutMethod() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "uid")
        self.performSegue(withIdentifier: "logout", sender: nil)
    }
    
    @objc private func logout() {
        logoutMethod()
    }
    
    @objc private func setCalories() {
        let alert = UIAlertController(title: "Type your calories goal", message: "", preferredStyle: .alert)
        
        alert.addTextField { textField in
                textField.placeholder = "Number of calories:"
            }
        
        let change = UIAlertAction(title: "Ok", style: .default) {_ in
            if let number = alert.textFields?.first?.text {
                self.changeCalories(with: Double(number) ?? 2000)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
        alert.addAction(change)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    fileprivate func changeCalories(with number: Double) {
        if let currentUser = fetchUser() {
            currentUser.caloriesGoal = (number) as NSNumber
            do {
                try managedObjectContext.save()
            }
            catch {
               print("Failed to change calories number")
           }
        }
    }
    
    @objc private func addRating() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    DispatchQueue.main.async {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                }
    }
    
    @objc private func deleteAccount() {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                print(error)
            }
        }
        let userCoreData = fetchUser()
        if let user = userCoreData {
            managedObjectContext.delete(user)
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Error deleting object: \(error.localizedDescription)")
            }
        }
        logoutMethod()
        
    }
    
    
    func changeFirebasePassword(newPassword: String, completion: @escaping (Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            // User is not logged in or authenticated
            completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        currentUser.updatePassword(to: newPassword) { error in
            completion(error)
        }
    }

    func changeCoreDataPassword(newPassword: String) {
        
            
            if let currentUser = fetchUser() {
                currentUser.password = newPassword
                do {
                    try managedObjectContext.save()
                }
                catch {
                   print("Failed to change user password")
               }
            }
         
    }
    
    @objc private func changePassword() {
        let alert = UIAlertController(title: "Change password", message: "", preferredStyle: .alert)
        
        alert.addTextField { textField in
                textField.placeholder = "New Password"
                textField.isSecureTextEntry = true
            }
        
        let change = UIAlertAction(title: "Ok", style: .default) {_ in
            if let newPassword = alert.textFields?.first?.text {
                self.changeFirebasePassword(newPassword: newPassword) { error in
                    print(error as Any)
                }
                self.changeCoreDataPassword(newPassword: newPassword)
                self.logoutMethod()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
        alert.addAction(change)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func fetchUser() -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        // Create a predicate to match the UUID
        let uuidPredicate = NSPredicate(format: "email == %@", self.email)
        fetchRequest.predicate = uuidPredicate
        
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
    
}
