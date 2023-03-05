
import UIKit


class FoodItem: UIView {
    
    
    private var placeholderYConstraint: NSLayoutConstraint?
    
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "placeholder"
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
    
    func configureFoodItem(with placeholder: String, keyboardType: UIKeyboardType = .default, tag: Int = 0) {
        //placeholderLabel.text = placeholder
        placeholderLabel.text = placeholder
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
        addSubview(placeholderLabel)
    }
    
    
    private func addConstraintsToSubviews() {
        layoutPlaceholder()
    }
    
    private func layoutPlaceholder() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        placeholderYConstraint = placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        placeholderYConstraint?.isActive = true
    }
}
