//
//  ViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 24.09.2022.
//

import UIKit

class RootController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
        loginButton.backgroundColor = .systemGreen
        registerButton.backgroundColor = .systemGreen
        loginButton.tintColor = .black
        registerButton.tintColor = .black
        self.view.alpha = 1
        let storedUsername = UserDefaults.standard.string(forKey: "username")
        let storedUid = UserDefaults.standard.string(forKey: "uid")
        if storedUsername != nil {
            redirectToMainPage()
        }
        
    }
        
        
        private func redirectToMainPage() {
            performSegue(withIdentifier: "skipLogin", sender: nil)
        }
        
        
        
        
        
    }
    
