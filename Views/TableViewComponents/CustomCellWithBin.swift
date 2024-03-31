import UIKit

final class CustomCellWithBin: UITableViewCell {
        
    static let identifier = "CustomCellWithBin"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.text = "Error"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        layoutViews()
    }
    
    private func setupViews() {
        self.contentView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            headerLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            headerLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -20),
            headerLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -10)
        ])
    }
    
    public func configure(with labelText: String) {
        headerLabel.text = labelText
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
