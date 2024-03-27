import UIKit
import RealmSwift

final class Notes: Object {
    @Persisted var id: String
    @Persisted var headerText: String
    @Persisted var bodyText: String
    
    convenience init(headerText: String, bodyText: String) {
        self.init()
        self.id = UUID().uuidString
        self.headerText = headerText
        self.bodyText = bodyText
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
