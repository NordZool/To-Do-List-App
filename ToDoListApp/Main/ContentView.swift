//
//  ContentView.swift
//  ToDoListApp
//
//  Created by admin on 16.08.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewController = ViewController()
    @ObservedObject var sectionController = SectionController()
    @ObservedObject var sections = Sections()
    @StateObject var settings = GlobalSettings()
    
    var body: some View {
        ZStack(alignment:.bottom) {
            TabView(selection:$viewController.viewPrisented) {
                SectionsView(sections: sections, sectionController: sectionController, viewController: viewController)
                    .tag(Present.sectionsView)
                    
                
//                    .tabItem {
//                        Image(systemName: "1.circle")
//                    }
                    
                if let selectionIndex = sectionController.chosenSection {
                    TasksView(
                        tasks: $sections.tasks[selectionIndex],
                        historyTasks: $sections.historyTasks[selectionIndex],
                        sectionName: $sections.section[selectionIndex].name,colorStyle: sections.section[selectionIndex].sectionStyle.locolToColor())
                    
                    .offset(y:5)
                    .tag(Present.tasksView)
//                    .tabItem {
//                        Image(systemName: "2.circle")
//                    }
                    
                } else {
                    Text("Not found any section")
                        .tag(Present.tasksView)
//                        .tabItem {
//                            Image(systemName: "2.circle")
//                        }
                }
                
                SettingsView()
                    .tag(Present.settingsView)
                
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color("StandartColorB"))
                    .frame(height:40)
                    .offset(y:-2)
                Rectangle()
                    .foregroundColor(Color("StandartColorW"))
                    .frame(height: 40)
//                    .overlay {
//                        Rectangle()
//
//                            .stroke(lineWidth: 2)
//                            .edgesIgnoringSafeArea(.bottom)
//                    }
                    
            }
            .edgesIgnoringSafeArea(.bottom)
            .transaction {transaction in
                transaction.animation = nil
            }
            
            HStack(spacing:83) {
      
                    Button {
                        withAnimation(.linear) {
                            viewController.viewPrisented = .sectionsView
                        }
                    } label: {
                        VStack {
                            Image(systemName: "list.clipboard")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 40,height: 30)
                                .foregroundColor(viewController.viewPrisented == .sectionsView ? Color("StandartColorB") : .gray)
                            Text("sections")
                                .scaleEffect(0.7)
                                .padding(.vertical,-10)
                                .foregroundColor(Color("StandartColorB"))
                        }
                    }
                
                
                VStack {
                    Button {
                        withAnimation(.linear) {
                            viewController.viewPrisented = .tasksView
                        }
                    } label: {
                        
                        if let selectionIndex = sectionController.chosenSection {
                            VStack {
                                Image(systemName: sections.section[selectionIndex].imageLable)
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(width: 40,height: 30)
                                    .foregroundColor(viewController.viewPrisented == .tasksView ? Color("StandartColorB") : .gray)
                                Text(sections.section[selectionIndex].name)
                                    .scaleEffect(0.7)
                                    .padding(.vertical,-10)
                                    .frame(width: 65)
                                    .foregroundColor(Color("StandartColorB"))
                                    .lineLimit(1)
                            }
                        } else {
                            VStack {
                                Image(systemName: "questionmark.app")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(width: 40,height: 30)
                                    .foregroundColor(viewController.viewPrisented == .tasksView ? Color("StandartColorB") : .gray)
                                Text("unknow")
                                    .scaleEffect(0.7)
                                    .padding(.vertical,-10)
                                    .frame(width: 65)
                                    .foregroundColor(Color("StandartColorB"))
                            }
                            
                        }
                    }
                    .transaction {transaction in
                        transaction.animation = nil
                    }
                    
                    
                }
                Button {
                    withAnimation(.linear) {
                        viewController.viewPrisented = .settingsView
                    }
                } label: {
                    VStack {
                        Image(systemName: "gearshape")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 40,height: 30)
                            .foregroundColor(viewController.viewPrisented == .settingsView ? Color("StandartColorB") : .gray)
                        Text("settings")
                            .scaleEffect(0.7)
                            .padding(.vertical,-10)
                            .frame(width: 65)
                            .foregroundColor(Color("StandartColorB"))
                    }
                }
                .transaction {transaction in
                    transaction.animation = nil
                }
            }
            .animation(.easeInOut, value: viewController.viewPrisented)
            .offset(y:5)
            
            
                
        }.environmentObject(settings)
            .preferredColorScheme(settings.theme)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
