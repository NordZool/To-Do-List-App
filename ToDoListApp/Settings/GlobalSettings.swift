import SwiftUI

//struct GlobalSettings : Codable {
//    var theme: ColorScheme = .light
//}

class GlobalSettings : ObservableObject {
    @Published var theme: ColorScheme = .light {
        didSet {
            if theme == .light {
                UserDefaults.standard.set("light", forKey: "theme")
            } else {
                UserDefaults.standard.set("dark", forKey: "theme")
            }
            
        }
        
    }
    var isDarkTheme: Bool {
        get {
            theme == .dark
        }
        set {
            if newValue {
                theme = .dark
            } else {
                theme = .light
            }
        }
    }
    
    init() {
        if let theme = UserDefaults.standard.string(forKey: "theme") {
            if theme == "light" {
                self.theme = .light
            } else if theme == "dark" {
                self.theme = .dark
            }
        }
    }
    
}
