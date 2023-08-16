import Foundation
struct Task : Codable, Identifiable{
    var id = UUID()
    
    var name: String
    var createTime: String?
    var doneTime: String?
    var done: Bool = false
}

//class Tasks : Codable, ObservableObject {
//    var tasks: [Task] = []
//}
