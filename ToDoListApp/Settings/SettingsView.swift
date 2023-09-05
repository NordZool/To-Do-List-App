//
//  SettingsView.swift
//  ToDoListApp
//
//  Created by admin on 2.09.23.
//

import SwiftUI

struct StartSettingsView: View {
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding(.leading,10)
            Form {
                Toggle(isOn: self.$settings.isDarkTheme, label: {Text("Dark theme")})
                Section("Local settings") {
                    Button("Name: "){}
                    Button("Icon: ") {}
                    Button("Color: ") {}
                }
                .disabled(true)
            }
        }
    }
    //        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
    
}

//    init(isDarkTheme:Bool = false) {
//        self.isDarkTheme = isDarkTheme
//    }

struct SettingsView: View {
    @EnvironmentObject var settings: GlobalSettings
    @Binding var name: String
    @Binding var icon: String
    @Binding var color: LocalColor
    //    @State private var isDarkTheme = false
    
    
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding(.leading,10)
            Form {
                Toggle(isOn: self.$settings.isDarkTheme, label: {Text("Dark theme")})
                Section("Local settings") {
                    
                    HStack(alignment:.center) {
                        Text("Name: ")
                        TextEditor(text: $name)
                    }
                    HStack {
                        Text("Icon: ")
                        Spacer()
                        Menu {
                            AddMenuSection(content: SingletonAssets.objectsAndTools_im, lable: "Objects & Tools", selected: $icon)
                            AddMenuSection(content: SingletonAssets.time_im, lable: "Time", selected: $icon)
                        } label: {
                            HStack {
                                
                                
                                Image(systemName: icon)
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .cornerRadius(13)
                                    .frame(width: 50,height: 50)
                                    .foregroundColor(color.locolToColor())
                            }
                        }
                    }
                    
                    HStack {
                        Text("Color: ")
                        Spacer()
                        Menu {
                            ForEach(LocalColor.allCases, id: \.self) {localColor in
                                Button {
                                    self.color = localColor
                                } label: {
                                    if localColor != .black {
                                        Text(localColor.rawValue)
                                    } else {
                                        Text(settings.theme == .dark ? "white" : "black")
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                color.locolToColor()
                                    .cornerRadius(13)
                                    .frame(width: 50,height: 50)
                            }
                        }
                    }
                    //
                }
                //                    .onChange(of: isDarkTheme) { _ in
                //                        withAnimation(.linear) {
                //                            settings.theme = isDarkTheme ? .dark : .light
                //                        }
                //                    }
            }
        }
        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
        
    }
}
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
