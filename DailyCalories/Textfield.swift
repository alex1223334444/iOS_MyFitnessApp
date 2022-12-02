//
//  Textfield.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 06.11.2022.
//

import UIKit

protocol TextFieldWithLabelDelegate: AnyObject{
    func changeText(_ textContent: UITextField?)
}

class Textfield: UIView {
    
    
    private var placeholderYConstraint: NSLayoutConstraint?
    weak var delegate: TextFieldWithLabelDelegate?
    private enum PlaceholderPosition {
        case raised, lowered
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    /*private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "placeholder"
        return label
    }()*/
    
    
    private lazy var bottomBorder: UIView = {
        let border = UIView()
        border.backgroundColor = .gray
        return border
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.systemGray4.withAlphaComponent(0.6)
        self.layer.cornerRadius = 20
        addSubviews()
        addConstraintsToSubviews()
        subscribeToActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.systemGray4.withAlphaComponent(0.6)
        self.layer.cornerRadius = 20
        addSubviews()
        addConstraintsToSubviews()
        subscribeToActions()
    }
    
    func configureTextField(with placeholder: String, keyboardType: UIKeyboardType = .default, secured: Bool = false, tag: Int = 0, delegate : TextFieldWithLabelDelegate) {
        //placeholderLabel.text = placeholder
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = secured
        textField.tag = tag
        self.delegate = delegate
    }
    
    
    private func subscribeToActions() {
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
    }
    
    @objc private func textFieldDidChangeText () {
        delegate?.changeText(textField)
    }
    
    private func addSubviews() {
        addSubview(textField)
        //addSubview(placeholderLabel)
        addSubview(bottomBorder)
    }
    
    private func animatePlaceholderLabel(position: PlaceholderPosition) {
        switch position {
        case .raised:
            animatePlaceholderUp()
        case .lowered:
            animatePlaceholderDown()
        }
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromBottom) {
            self.layoutIfNeeded()
        }
    }
    
    private func animatePlaceholderDown() {
        if let textFieldText = textField.text, textFieldText.isEmpty{
            placeholderYConstraint?.constant = 0
            //placeholderLabel.textColor = .gray
            //placeholderLabel.font = .systemFont(ofSize: 14)
            bottomBorder.backgroundColor = .gray
        }
    }
    
    private func animatePlaceholderUp() {
        self.placeholderYConstraint?.constant = -16
    }
    
    @objc private func textFieldDidEndEditing() {
        //placeholderLabel.textColor = .black
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .black
        //textField.backgroundColor = .white
        bottomBorder.backgroundColor = .black
        self.layer.masksToBounds = true
        animatePlaceholderLabel(position: .lowered)
    }
    
    @objc private func textFieldDidBeginEditing() {
        //placeholderLabel.textColor = .black
        //placeholderLabel.font = .systemFont(ofSize: 12)
        self.layer.masksToBounds = true
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15)
        animatePlaceholderLabel(position: .raised)
    }
    
    private func addConstraintsToSubviews() {
        layoutTextField()
        layoutBorder()
        //layoutPlaceholder()
    }
    
    private func layoutTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func layoutBorder() {
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    /*private func layoutPlaceholder() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        placeholderYConstraint = placeholderLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        placeholderYConstraint?.isActive = true
    }*/
}
