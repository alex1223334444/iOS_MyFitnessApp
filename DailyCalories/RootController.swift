//
//  ViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 24.09.2022.
//

import UIKit

class RootController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 25
        registerButton.layer.cornerRadius = 20
        self.view.alpha = 1
        if let storedUsername = UserDefaults.standard.string(forKey: "username"),
           let storedPassword = UserDefaults.standard.string(forKey: "uid") {
            // User is already logged in, redirect to the main page
            redirectToMainPage()
            // Do any additional setup after loading the view.
        }
    }
        
        
        private func redirectToMainPage() {
            performSegue(withIdentifier: "skipLogin", sender: nil)
        }
        
        
        
        
        
    }
    
