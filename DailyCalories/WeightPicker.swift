//
//  WeightPicker.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 19.04.2023.
//

import UIKit

class WeightPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    var selectedUnit: String = "g"
    let weightOptions = ["g", "oz", "lbs"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        selectedUnit = weightOptions[row]
        return selectedUnit
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.dataSource = self
        self.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
