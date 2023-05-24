
import UIKit


class FoodItem: UIView {
    
    
    private var placeholderYConstraint: NSLayoutConstraint?
    
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "recipe"
        return label
    }()
    
    private lazy var calories: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "0"
        return label
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "calories"
        return label
    }()
    
    
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
    
    func configureFoodItem(with recipeName: String, caloriesNr: Int, keyboardType: UIKeyboardType = .default, tag: Int = 0) {
        //placeholderLabel.text = placeholder
        name.text = recipeName
        calories.text = String(caloriesNr)
        self.tag = tag
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.systemGray4.withAlphaComponent(0.6)
        self.layer.cornerRadius = 20
        addSubviews()
        addConstraintsToSubviews()
        subscribeToActions()
    }
    
    private func subscribeToActions() {
        
    }
    
    private func addSubviews() {
        addSubview(name)
        addSubview(calories)
        addSubview(label)
    }
    
    
    private func addConstraintsToSubviews() {
        layoutName()
        layoutCalories()
        layoutCaloriesLabel()
    }
    
    private func layoutName() {
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        placeholderYConstraint = name.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        placeholderYConstraint?.isActive = true
    }
    
    private func layoutCalories() {
        calories.translatesAutoresizingMaskIntoConstraints = false
        calories.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -35).isActive = true
        placeholderYConstraint = calories.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        placeholderYConstraint?.isActive = true
    }
    
    private func layoutCaloriesLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
        placeholderYConstraint = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        placeholderYConstraint?.isActive = true
    }
}
