import UIKit
import RealmSwift

final class RealmService {
    
    static var shared = RealmService()
    
    let localRealm = try! Realm()
}
