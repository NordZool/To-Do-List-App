import SwiftUI

class SectionController : ObservableObject {
    @Published var chosenSection:Int? = nil {
        didSet {
            UserDefaults.standard.set(chosenSection, forKey: "ChosenSection")
        }
    }
    @Published var lastColor = LocalColor.green {
        didSet {
            if let encoded = try? JSONEncoder().encode(lastColor) {
                UserDefaults.standard.set(encoded, forKey: "LastColor")
            }
        }
    }
    @Published var lastIcon = SingletonAssets.time_im[0] {
        didSet {
                UserDefaults.standard.set(lastIcon, forKey: "LastIcon")
        }
    }
    
    init() {
//        chosenSection = UserDefaults.standard.integer(forKey: "ChosenSection")
        chosenSection = nil //временно
        lastIcon = UserDefaults.standard.string(forKey: "LastIcon") ?? SingletonAssets.time_im[0]
        
        if let lastColor = UserDefaults.standard.data(forKey: "LastColor") {
            if let decoded = try? JSONDecoder().decode(LocalColor.self, from: lastColor) {
                self.lastColor = decoded
            }
        }
    }
}
