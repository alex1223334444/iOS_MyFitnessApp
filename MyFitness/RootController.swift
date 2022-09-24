//
//  ViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 24.09.2022.
//

import UIKit

struct Constants {
    static let firstButton = 1
}

class RootController: UIViewController {
    var loginViewController: LoginViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButton(_ sender: UIButton) {
        let tag = sender.tag;
        
        // Create the new view controller, if required.
        if (tag == Constants.firstButton) {
            if (loginViewController == nil) {
                loginViewController = (self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController)
            }
        }
        
        // Switch view controllers.
        if (tag == Constants.firstButton) {
            loginViewController?.view.frame = view.frame
            switchToViewController(loginViewController)
            //present(UIViewController: firstViewController, animated: true, completion: nil)
        }
    }
    
    func switchToViewController(_ toVC: UIViewController?) {
        if (toVC != nil) {
            addChild((toVC)!)
            view.addSubview((toVC?.view)!)
            toVC?.didMove(toParent: self)
        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        print("register")
    }
    
}

