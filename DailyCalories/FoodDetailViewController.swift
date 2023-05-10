//
//  FoodDetailViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 10.05.2023.
//

import UIKit

class FoodDetailViewController: UIViewController {
    private let contentView = UIView()
    private let handleView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let caloriesLabel = UILabel()
    var name: String = ""
    private var panGesture: UIPanGestureRecognizer!
    private var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view and subviews
        view.backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        handleView.backgroundColor = .lightGray
        handleView.layer.cornerRadius = 2
        titleLabel.text = ""
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        descriptionLabel.text = name
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        caloriesLabel.text = "Calories:  0)"
        caloriesLabel.font = UIFont.systemFont(ofSize: 16)
        
        // Add subviews to the view hierarchy
        view.addSubview(contentView)
        contentView.addSubview(handleView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(caloriesLabel)
        
        // Set up constraints for the subviews
        contentView.translatesAutoresizingMaskIntoConstraints = false
        handleView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2),
            
            handleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            handleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            handleView.widthAnchor.constraint(equalToConstant: 40),
            handleView.heightAnchor.constraint(equalToConstant: 4),
            
            titleLabel.topAnchor.constraint(equalTo: handleView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            caloriesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            caloriesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            caloriesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            caloriesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        // Set up the pan gesture recognizer
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        contentView.addGestureRecognizer(panGesture)
    }
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        switch gesture.state {
        case .began:
            initialTouchPoint = contentView.frame.origin
        case .changed:
            let maxY = initialTouchPoint.y + contentView.frame.height - view.safeAreaInsets.bottom - contentView.frame.height / 2
            let newOriginY = max(initialTouchPoint.y + translation.y, maxY)
            let newFrame = CGRect(x: 0, y: newOriginY, width: contentView.frame.width, height: contentView.frame.height)
            contentView.frame = newFrame
        case .ended, .cancelled:
            let velocity = gesture.velocity(in: view)
            let maxY = initialTouchPoint.y + contentView.frame.height - view.safeAreaInsets.bottom - contentView.frame.height / 2
            let endY = initialTouchPoint.y + contentView.frame.height / 2
            let shouldDismiss = velocity.y >= 1500 || contentView.frame.origin.y > initialTouchPoint.y + contentView.frame.height / 4
            if shouldDismiss {
                // Disable the gesture recognizer to prevent the user from swiping down twice
                contentView.removeGestureRecognizer(panGesture)

                // Dismiss the view controller if the user is swiping down quickly or dragged it more than a quarter of the way down
                dismiss(animated: true, completion: nil)
            } else if contentView.frame.origin.y > maxY {
                // Snap the view to its maximum position
                UIView.animate(withDuration: 0.3) {
                    self.contentView.frame = CGRect(x: 0, y: maxY, width: self.contentView.frame.width, height: self.contentView.frame.height)
                }
            } else {
                // Snap the view back to its original position
                UIView.animate(withDuration: 0.3) {
                    self.contentView.frame = CGRect(x: 0, y: endY, width: self.contentView.frame.width, height: self.contentView.frame.height)
                }
            }
        default:
            break
        }
    }

}
