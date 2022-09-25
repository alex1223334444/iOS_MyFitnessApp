//
//  SettingsViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 25.09.2022.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        // Number of columns of data
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        // The number of rows of data
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerData.count
        }
        
        // The data to return fopr the row and component (column) that's being passed in
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerData[row]
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        pickerData = ["male","female"]
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var genderPicker: UIPickerView!
    var pickerData: [String] = [String]()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
