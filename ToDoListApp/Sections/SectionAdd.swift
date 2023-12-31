//
//  SectionAdd.swift
//  hz
//
//  Created by admin on 4.08.23.
//

import SwiftUI
import Combine

    
struct SectionAdd: View {
    @Environment (\.dismiss) private var dismiss
    @EnvironmentObject var settings: GlobalSettings
    
    var sections: Sections
    @Binding var localColor: LocalColor
    @Binding var localLable: String // мб байндинг
    @State private var sectionName = ""
    let textLimit = 34 // поменять
    
    @State private var emptyError = false
    
//    @ObservedObject var sectionController: SectionController
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(localColor.locolToColor())
                .cornerRadius(40)
                .opacity(0.8)
                .overlay {
                    Rectangle()
                        .fill(Color("StandartColorW"))
                        .frame(width: 385,height: 840)
                        .cornerRadius(60)
                        
                }
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 4)
                .opacity(settings.theme == .dark ? 1 : 0.7)// при dark = 1, при light = 0.7
                //убрать lineLimit + при dark - блэк на white менять и наобород del
            VStack(spacing: -20) {
                ZStack {
                    
                    
                    Rectangle()
                        .fill(localColor.locolToColor())
                        .blur(radius: 100)
                        .cornerRadius(60)
                        .overlay {
                            Rectangle()
                                .fill(Color("StandartColorW"))
                                .cornerRadius(70)
                            //                    .frame(height: 350)
                                .scaleEffect(0.97)
                        }
                        .frame(width: 391, height: 300)
                    
                    VStack {
                        VStack(spacing:0) {
                            ZStack(alignment:.topLeading) {
                                if sectionName.isEmpty {
                                    Text("Section name...")
                                        .foregroundColor(.gray)
                                        .offset(x:3,y:12)
                                }
                                    
                                    TextEditor(text: $sectionName)
                                    
                                    //                    .frame(height: 100)
                                    //                    .background(.gray)
                                        .scrollContentBackground(.hidden)
                                        .onChange(of: sectionName) {_ in
                                            emptyError = false
                                        }
                                        .padding(0)
                            }
                            VStack {
                                Rectangle()
                                    .frame(width: 293, height:1)
                                    .padding(.top, -60 + CGFloat(sectionName.filter({$0 == "\n"}).count * 22))
                                HStack {
                                    Spacer()
                                    if sectionName.count == 34 {
                                        Text("You can only use \(textLimit) sumbols")
                                            .foregroundColor(.yellow)
                                            .padding(.top, -67 + CGFloat(sectionName.filter({$0 == "\n"}).count * 22))
                                            .font(.footnote)
                                    }
                                    if emptyError {
                                        Text("Fill the field")
                                            .foregroundColor(.red)
                                            .padding(.top, -67 + CGFloat(sectionName.filter({$0 == "\n"}).count * 22))
                                            .font(.footnote)
                                    }
                                }
                            }
                          
                            
                        }
                        .frame(width: 300,height: 100)
                        .padding(.horizontal, 10)
                        .padding(.bottom, -50)
                        .onReceive(Just(sectionName)) { _ in limitText(textLimit) }
                        VStack(spacing: 20){ //menu
                            HStack {
                                Text("Lable: ")
                                    .font(.title)
                                Spacer()
                                Menu {
                                    AddMenuSection(content: SingletonAssets.objectsAndTools_im, lable: "Objects & Tools", selected: $localLable)
                                    AddMenuSection(content: SingletonAssets.time_im, lable: "Time", selected: $localLable)
                                } label: {
                                    HStack {
                                        
                                        
                                        Image(systemName: localLable)
                                            .resizable()
                                            .aspectRatio( contentMode: .fit)
                                            .cornerRadius(13)
                                            .frame(width: 50,height: 50)
                                            .foregroundColor(localColor.locolToColor())
                                    }
                                }
                            }
                            HStack {
                                Text("Style: ")
                                    .font(.title)
                                Spacer()
                                Menu {
                                    
                                    ForEach(LocalColor.allCases, id: \.self) {color in
                                        Button {
                                                localColor = color
                                        } label: {
                                            if color != .black {
                                                Text(color.rawValue)
                                            } else {
                                                Text(settings.theme == .dark ? "white" : "black")
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        
                                        
                                        localColor.locolToColor()
                                            .cornerRadius(13)
                                            .frame(width: 50,height: 50)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 48)
                        
                    }
                    
                }
                .offset(y:-80)
                
                HStack(spacing: 83) {
                    Button(role: .cancel) {
                        dismiss.callAsFunction()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color("StandartColorB"))
                            .frame(width: 96,height: 36)
                            .background(.gray)
                            .cornerRadius(30)
                            .padding(2)
                            .background(localColor.locolToColor().opacity(settings.theme == .dark ? 1 : 0.7).blur(radius: 2)) // в дарк = 1
                            .cornerRadius(30)
                            .scaleEffect(1.7)
                    }
                    
                    
                    Button {
                        if sectionName.isEmpty || sectionName.allSatisfy({$0 == " " || $0 == "\n"}) {
                            emptyError = true
                        } else {
                            let newSection = TaskSection(
                                imageLable: localLable,
                                name: sectionName,
                                sectionStyle: localColor)
                            sections.section.append(newSection)
                            sections.tasks.append([])
                            sections.historyTasks.append([])
                            dismiss.callAsFunction()
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(Color("StandartColorB"))
                            .frame(width: 100,height: 40)
                            .background(.cyan)
                            .cornerRadius(30)
                            .padding(2)
//                            .background(localColor.locolToColor().opacity(0.7).blur(radius: 2))
//                            .cornerRadius(30)
                            
                            .scaleEffect(1.7)
                    }

                }
                .padding(.top, -20)
            }
        }
        .preferredColorScheme(settings.theme)
    }
        
    
    func limitText(_ upper: Int) {
        if sectionName.filter({$0 == "\n"}).count == 2 {
            while sectionName.last != "\n" {
                sectionName.removeLast()
            }
            sectionName.removeLast()
            
        }
        if sectionName.count > upper {
            sectionName = String(sectionName.prefix(upper))
        }
    }
}

//struct SectionAdd_Previews: PreviewProvider {
//    static var previews: some View {
//        SectionAdd(sections: Sections(), sectionController: SectionController())
////            .frame(width: 100)
//    }
//}
