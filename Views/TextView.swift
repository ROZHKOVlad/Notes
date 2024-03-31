import UIKit

final class TextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        keyboardType = .default
        showsVerticalScrollIndicator = false
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        keyboardDismissMode = .onDrag
    }
}
