import UIKit
import RealmSwift

final class NotesService {
    
    var notes: [Notes] = RealmService.shared.localRealm.objects(Notes.self).map({
            $0
        })
    
    func deleteNote(id: String) {
        guard let note = RealmService.shared.localRealm.object(ofType: Notes.self, forPrimaryKey: id) else { return }
        RealmService.shared.localRealm.delete(note)
    }
    
    func addNote(headerText: String, bodyText: String) {
        let note = Notes(headerText: headerText, bodyText: bodyText)
        try? RealmService.shared.localRealm.write {
            RealmService.shared.localRealm.add(note, update: .all)
        }
    }
    
    func updateNote(id: String, headerText: String?, bodyText: String?) {
        guard let note = RealmService.shared.localRealm.object(ofType: Notes.self, forPrimaryKey: id) else { return }
        try! RealmService.shared.localRealm.write({
            if headerText != nil {
                note.headerText = headerText!
            }
            if bodyText != nil {
                note.bodyText = bodyText!
            }
        })
    }
}

