import UIKit
import RealmSwift

final class CurrentNoteViewController: UIViewController, UITextFieldDelegate {
    
    private let addBarButton = UIBarButtonItem()
    private var headerTextField = TextField()
    private var bodyTextView = TextView()
        
    private let notesService = NotesService()
    var headerTextFieldText: String = ""
    var bodyTextFieldText: String = ""
    
    init(headerTextFieldText: String, bodyTextFieldText: String) {
        super.init(nibName: nil, bundle: nil)
        self.bodyTextFieldText = bodyTextFieldText
        self.headerTextFieldText = headerTextFieldText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "Add Note"
        
        addBarButton.title = "Confirm"
        addBarButton.tintColor = .systemBlue
        addBarButton.action = #selector(saveNote)
        addBarButton.target = self
        navigationItem.rightBarButtonItem = addBarButton
        
        headerTextField.delegate = self
        headerTextField.font = UIFont.systemFont(ofSize: 25)
        headerTextField.text = headerTextFieldText
        headerTextField.layer.cornerRadius = 10
        headerTextField.layer.borderWidth = 1
        headerTextField.layer.borderColor = UIColor.systemBlue.cgColor
        view.addSubview(headerTextField)
        
        bodyTextView.font = UIFont.systemFont(ofSize: 20)
        bodyTextView.text = bodyTextFieldText
        view.addSubview(bodyTextView)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            headerTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            headerTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerTextField.heightAnchor.constraint(equalToConstant: 40),
            headerTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            
            bodyTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            bodyTextView.topAnchor.constraint(equalTo: headerTextField.bottomAnchor, constant: 5),
            bodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bodyTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10)
        ])
    }
    
    @objc
    private func saveNote() {
        headerTextFieldText = headerTextField.text ?? ""
        bodyTextFieldText = bodyTextView.text ?? ""
        if headerTextFieldText == "" {
            let alert = UIAlertController(title: "Check your note", message: "There is an empty header", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            notesService.addNote(headerText: headerTextFieldText, bodyText: bodyTextFieldText)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        headerTextField.resignFirstResponder()
        return true
    }
}
