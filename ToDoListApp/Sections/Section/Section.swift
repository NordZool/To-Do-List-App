import SwiftUI

struct TaskSection : Codable, Identifiable{
    var id = UUID()
    
    var imageLable: String
    var sectionStyle: LocalColor
    var name: String
    
    
    init(id: UUID = UUID(), imageLable: String, name: String, sectionStyle: LocalColor) {
        self.id = id
        self.imageLable = imageLable
        self.name = name
        self.sectionStyle = sectionStyle
    }
}

class Sections : ObservableObject {
    @Published var section: [TaskSection] = []
    @Published var tasks: [[Task]] = []
    @Published var historyTasks: [[Task]] = []
    
    init(section: [TaskSection] = [], tasks: [[Task]] = [], historyTasks: [[Task]] = []) {
        self.section = section
        self.tasks = tasks
        self.historyTasks = historyTasks
    }
}
    
