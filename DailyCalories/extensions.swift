//
//  extensions.swift
//  DailyCalories
//
//  Created by Udrea Alexandru-Iulian-Alberto on 05.03.2023.
//

import Foundation
import UIKit


extension UIViewController {

    func addHeader(string: String){
        let header: UIView = UIView(frame: CGRect(x: 0, y: view.safeAreaInsets.top - 40, width: view.frame.width, height: 100))
        header.backgroundColor = .black
        let label: UILabel = UILabel()
        label.text = string
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.frame = CGRect(x: header.frame.width/2 - 50, y: header.frame.height/2 - 10, width: 100, height: 20)
        header.addSubview(label)
        let image = UIImage(named: "blackLogo")
        let imageView: UIImageView = UIImageView(image: image)
        imageView.backgroundColor = .white
        imageView.frame = CGRect(x: 10, y: header.frame.height/2 - 50, width: 100, height: 100)
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        header.addSubview(imageView)
        self.view.addSubview(header)
        
    }
}
