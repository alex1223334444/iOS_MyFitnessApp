//
//  RegisterViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 24.09.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    var settingsViewController: SettingsViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func buttonPressGoBack(_ sender: UIButton) {
        willMove(toParent: nil)
           view.removeFromSuperview()
        removeFromParent()
       }

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func registerButton(_ sender: UIButton) {
        if let username = username.text
        {
            if let password = password.text {
                print("\(username) \(password)")
            }
        }
        
            if (settingsViewController == nil) {
                settingsViewController = (self.storyboard?.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController)
        }
        
        // Switch view controllers.
        
            settingsViewController?.view.frame = view.frame
            switchToViewController(settingsViewController)
            //present(UIViewController: firstViewController, animated: true, completion: nil)
    }
    
    func switchToViewController(_ toVC: UIViewController?) {
        if (toVC != nil) {
            addChild((toVC)!)
            view.addSubview((toVC?.view)!)
            toVC?.didMove(toParent: self)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
