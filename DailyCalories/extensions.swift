//
//  extensions.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 05.03.2023.
//

import Foundation
import UIKit


extension UIViewController {

    func addHeader(){
        let header: UIView = UIView(frame: CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: 100))
        header.backgroundColor = .black
        let label: UILabel = UILabel()
        label.text = "Daily Calories"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.frame = CGRect(x: header.frame.width/2 - 50, y: header.frame.height/2 - 10, width: 100, height: 20)
        header.addSubview(label)
        let imageView: UIImageView = UIImageView(image: .none)
        imageView.backgroundColor = .white
        imageView.frame = CGRect(x: 10, y: header.frame.height/2 - 25, width: 50, height: 50)
        imageView.layer.cornerRadius = imageView.layer.bounds.width / 2
        imageView.clipsToBounds = true
        header.addSubview(imageView)
        self.view.addSubview(header)
        
    }
}
