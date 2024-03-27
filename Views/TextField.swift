import UIKit

final class TextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        layoutView()
    }
    
    private func setupView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        keyboardType = .default
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        textInputView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            textInputView.topAnchor.constraint(equalTo: self.topAnchor),
            textInputView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
