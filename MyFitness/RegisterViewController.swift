//
//  RegisterViewController.swift
//  MyFitness
//
//  Created by Udrea Alexandru-Iulian-Alberto on 24.09.2022.
//

import UIKit

class RegisterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TextFieldWithLabelDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    var placeholders = ["First name", "Last name", "E-mail", "Phone number", "Password"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.gradientBackground(from: .magenta,to: .orange, direction: .bottomToTop)
        button.layer.cornerRadius = 8

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return placeholders.count
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textfield", for: indexPath) as? TextfieldTableViewCell else {
                return UITableViewCell()
            }
        cell.configureTextFieldCell(placeholders[indexPath.section], tag: indexPath.section, secure: false, delegate : self)
            cell.showsReorderControl = true
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 5
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    func changeText(_ textContent: UITextField?) {
        self.button.isEnabled = true
    }
    
}
