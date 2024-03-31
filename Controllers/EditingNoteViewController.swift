import UIKit
import RealmSwift

final class EditingNoteViewController: UIViewController, UITextFieldDelegate {
    
    private let addBarButton = UIBarButtonItem()
    private let deleteBarButton = UIBarButtonItem()
    private var headerTextField = TextField()
    private var bodyTextField = TextView()
    
    private let notesService = NotesService()
    var headerTextFieldText: String = ""
    var bodyTextFieldText: String = ""
    var id: String = ""
    
    init(headerTextFieldText: String, bodyTextFieldText: String) {
        super.init(nibName: nil, bundle: nil)
        self.bodyTextFieldText = bodyTextFieldText
        self.headerTextFieldText = headerTextFieldText
        let note = notesService.notes.first(where: { $0.bodyText == bodyTextFieldText && $0.headerText == headerTextFieldText})
        id = note?.id ?? ""
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
        title = "Note"
        
        addBarButton.title = "Back"
        addBarButton.tintColor = .systemBlue
        addBarButton.action = #selector(editNote)
        addBarButton.target = self
        navigationItem.leftBarButtonItem = addBarButton
        
        deleteBarButton.title = "Delete"
        deleteBarButton.tintColor = .systemRed
        deleteBarButton.action = #selector(deleteNote)
        deleteBarButton.target = self
        navigationItem.rightBarButtonItem = deleteBarButton
        
        headerTextField.delegate = self
        headerTextField.font = UIFont.systemFont(ofSize: 25)
        headerTextField.layer.cornerRadius = 10
        headerTextField.layer.borderWidth = 1
        headerTextField.layer.borderColor = UIColor.systemBlue.cgColor
        headerTextField.text = headerTextFieldText
        view.addSubview(headerTextField)
        
        bodyTextField.font = UIFont.systemFont(ofSize: 20)
        bodyTextField.text = bodyTextFieldText
        view.addSubview(bodyTextField)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            headerTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            headerTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerTextField.heightAnchor.constraint(equalToConstant: 40),
            headerTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            
            bodyTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            bodyTextField.topAnchor.constraint(equalTo: headerTextField.bottomAnchor, constant: 5),
            bodyTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bodyTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10)
        ])
    }
    
    @objc
    private func editNote() {
        headerTextFieldText = headerTextField.text ?? ""
        bodyTextFieldText = bodyTextField.text ?? ""
        if headerTextFieldText == "" {
            let alert = UIAlertController(title: "Check your note", message: "There is an empty line", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if id != "" {
                notesService.updateNote(id: id,headerText: headerTextFieldText, bodyText: bodyTextFieldText)
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc
    private func deleteNote() {
        let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            self.notesService.deleteNote(id: self.id)
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        headerTextField.resignFirstResponder()
        bodyTextField.resignFirstResponder()
        return true
    }
}
