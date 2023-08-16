import Foundation

class ViewController : ObservableObject {
    @Published var viewPrisented: Present = .tasksView
}


enum Present : String{
    case tasksView
    case sectionsView
    case settingsView
}
