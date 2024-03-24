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
    
    func addNote(headText: String, text: String, type: Int) {
        let note = Notes(headText: headText, text: text, type: type)
        try? RealmService.shared.localRealm.write {
            RealmService.shared.localRealm.add(note, update: .all)
        }
    }
    
    func updateNote(id: String, headText: String?, text: String?, type: Int?) {
        guard let note = RealmService.shared.localRealm.object(ofType: Notes.self, forPrimaryKey: id) else { return }
        if headText != nil {
            note.headText = headText!
        }
        if text != nil {
            note.text = text!
        }
        if type != nil {
            note.type = type!
        }
        RealmService.shared.localRealm.add(note, update: .all)
    }
}

