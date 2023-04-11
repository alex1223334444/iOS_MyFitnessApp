//
//  HomeViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 27.02.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var addFoodButton: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addHeader(string: "Home")
        
        
        
    }
    
    @IBAction func addFood(_ sender: Any) {
        print("da")
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
