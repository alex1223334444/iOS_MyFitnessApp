//
//  Button.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 06.11.2022.
//

import UIKit

protocol ButtonDelegate: AnyObject{
    func buttonTouchUpInside()
}

class Button: UIView {
    weak var delegate : ButtonDelegate?
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraintsToSubviews()
        subscribeToActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        addConstraintsToSubviews()
        subscribeToActions()
    }
    
    private func subscribeToActions() {
        button.addTarget(self, action: #selector(buttonPushed), for: .touchUpInside)
    }
    
    private func addSubviews() {
        addSubview(button)
    }
    
    @objc private func buttonPushed() {
        delegate?.buttonTouchUpInside()
    }
    
    private func addConstraintsToSubviews() {
        layout()
    }
    
    func configureButton(title: String, delegate : ButtonDelegate) {
        self.button.setTitle(title, for: .normal)
        self.button.isEnabled = false
        self.button.setTitleColor(.gray, for: .disabled)
        self.delegate = delegate
    }
    
    func enable(enabled : Bool)
    {
        self.button.isEnabled = enabled
    }
    
    private func layout() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        //button.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        //button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        button.titleLabel?.textAlignment = .center
    }
}
