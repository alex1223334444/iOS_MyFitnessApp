//
//  TextfieldTableViewCell.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 29.11.2022.
//

import UIKit

class TextfieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textfield: Textfield!
    func configureTextFieldCell(_ placeholder: String, tag: Int = 0 ,secure: Bool,delegate: TextFieldWithLabelDelegate, image: String?){
        textfield.configureTextField(with: placeholder, secured: secure, tag: tag, delegate: delegate, image: image)
      }

    
}
