//
//  ProfileViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 20.02.2023.
//

import UIKit
import CoreData
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addHeader(string: "Profile")
        addLogoutButton()
        addGoalButton()
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
        let deleteButton = UIButton()
        self.view.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150)
        ])
        deleteButton.setTitle("Delete account", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.addTarget(self, action:#selector(self.deleteAccount), for: .touchUpInside)
    }
    
    fileprivate func addLogoutButton() {
        let logoutButton = UIButton()
        self.view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
    
    fileprivate func addGoalButton() {
        let goalButton = UIButton()
        self.view.addSubview(goalButton)
        goalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
        goalButton.setTitle("Add calories goal", for: .normal)
        goalButton.setTitleColor(.black, for: .normal)
        goalButton.addTarget(self, action:#selector(self.changeCalorieGoal), for: .touchUpInside)
    }
    
    fileprivate func addChangePasswordButton() {
        let changePassword = UIButton()
        self.view.addSubview(changePassword)
        changePassword.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changePassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changePassword.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
        changePassword.setTitle("Change your password", for: .normal)
        changePassword.setTitleColor(.black, for: .normal)
        changePassword.addTarget(self, action:#selector(self.logout), for: .touchUpInside)
    }
    
    @objc private func logout() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "uid")
        self.performSegue(withIdentifier: "logout", sender: nil)
    }
    
    
    @objc private func changeCalorieGoal() {
        UserDefaults.standard.removeObject(forKey: "username")
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
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "uid")
        self.performSegue(withIdentifier: "logout", sender: nil)
        
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
