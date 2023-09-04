import SwiftUI

struct LocalSectionSettings : Codable {
    var localColor = LocalColor.green
    func colorNow() -> Color {
        localColor.locolToColor()
            
    }
}


enum LocalColor : String, Codable, CaseIterable{
//    case white //don't used on light theme
    case black
    case green
    case blue
    case red
    case purple
    
    func locolToColor() -> Color {
//        @EnvironmentObject var settings: GlobalSettings
        switch self {
        case .black:
            return Color("StandartColorB") // если темная тема - то .black = .white иначе .white = .black
        case .green:
            return .green
        case .blue:
            return .blue
        case .red:
            return .red
        case .purple:
            return .purple
       
            
        }
    }
}

