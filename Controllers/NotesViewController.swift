import UIKit
import RealmSwift

final class NotesViewController: UIViewController {
    
    private let addBarButton = UIBarButtonItem()
    private let deleteOnBarButton = UIBarButtonItem()
    private let deleteOffBarButton = UIBarButtonItem()
    private let tableView = TableView()
    private var modeIdentifier = CustomCell.identifier
    
    private var notes: [Notes] = []
    private var token: NotificationToken?
    
    private var pushViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
        updateData()
        token = RealmService.shared.localRealm.observe({ [weak self] _, realm in
            self?.updateData()
        })
    }
    
    private func setupViews() {
        title = "Notes"
        view.backgroundColor = .white
        
        addBarButton.title = "Add"
        addBarButton.tintColor = .systemBlue
        addBarButton.action = #selector(pushCurrentViewController)
        addBarButton.target = self
        navigationItem.rightBarButtonItem = addBarButton
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc 
    private func pushCurrentViewController() {
        let vc = CurrentNoteViewController(headerTextFieldText: "", bodyTextFieldText: "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -20)
        ])
    }
    
    private func updateData() {
        let notesService = NotesService()
        notes = notesService.notes
        tableView.reloadData()
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: modeIdentifier, for: indexPath) as? CustomCell else { fatalError("The TableView could not dequeue a CustomCell") }
        let headerText = notes[indexPath.row].headerText
        cell.configure(with: headerText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let headerText = notes[indexPath.row].headerText
        let bodyText = notes[indexPath.row].bodyText
        if(modeIdentifier == CustomCell.identifier) {
            pushViewController = EditingNoteViewController(headerTextFieldText: headerText, bodyTextFieldText: bodyText)
            navigationController?.pushViewController(pushViewController, animated: true)
        }
    }
    
    
}

