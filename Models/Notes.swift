import UIKit
import RealmSwift

final class Notes: Object {
    @Persisted private var id: String
    @Persisted var headText: String
    @Persisted var text: String
    @Persisted var type: Int
    
    convenience init(headText: String, text: String, type: Int) {
        self.init()
        self.id = UUID().uuidString
        self.headText = headText
        self.text = text
        self.type = type
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
