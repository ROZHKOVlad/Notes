import UIKit
import RealmSwift

final class RealmService {
    
    static var shared = RealmService()
    
    lazy var localRealm: Realm = {
        return try! Realm()
    }()
}
