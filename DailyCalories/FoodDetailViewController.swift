//
//  FoodDetailViewController.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 10.05.2023.
//

import UIKit
import SwiftUI

class FoodDetailViewController: UIViewController {
    private let caloriesLabel = UILabel()
    var food: Food = Food()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let customSwiftUIView = SwiftUIView(food: food)
        let hostingController = UIHostingController(rootView: customSwiftUIView)
                
        addChild(hostingController)
        view.addSubview(hostingController.view)
                
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
                
        hostingController.didMove(toParent: self)
        
        
        
        
        
    }
    

}
