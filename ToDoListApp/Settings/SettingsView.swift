//
//  SettingsView.swift
//  ToDoListApp
//
//  Created by admin on 2.09.23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: GlobalSettings
//    @State private var isDarkTheme = false
    
    
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding(.leading,10)
            Form {
                Toggle(isOn: self.$settings.isDarkTheme, label: {Text("Dark theme")})
//                    .onChange(of: isDarkTheme) { _ in
//                        withAnimation(.linear) {
//                            settings.theme = isDarkTheme ? .dark : .light
//                        }
//                    }
            }
        }
        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
        
    }
    
//    init(isDarkTheme:Bool = false) {
//        self.isDarkTheme = isDarkTheme
//    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
