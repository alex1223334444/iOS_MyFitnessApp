//
//  ButtonTableViewCell.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 29.11.2022.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    func configureButton(title: String){
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 8
    }
    
    func enableButton(enabled : Bool){
        button.isEnabled = enabled
    }
    

}
