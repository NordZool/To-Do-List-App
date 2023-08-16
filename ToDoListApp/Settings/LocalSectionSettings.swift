import SwiftUI

struct LocalSectionSettings : Codable {
    var localColor = LocalColor.green
    func colorNow() -> Color {
        localColor.locolToColor()
    }
}


enum LocalColor : String, Codable, CaseIterable{
    case black
    case green
    case blue
    case red
    case purple
    
    func locolToColor() -> Color {
        switch self {
        case .black:
            return .black
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
