//
//  SectionsView.swift
//  hz
//
//  Created by admin on 30.07.23.
//

import SwiftUI

struct SectionsView: View {
    //add States
    @State private var onAdd = false
    @State private var viewAddView = false
    //    @State private var
    @State private var editedSectionName = ""
    @State private var indexEditedSection: Int?
    
    @ObservedObject var sections: Sections
    @ObservedObject var sectionController: SectionController
    @ObservedObject var viewController: ViewController
    var body: some View {
        
        VStack {
            if sections.section.isEmpty {
                Spacer(minLength: 290)
                Text("Not found\n any records \n😔")
                    .lineSpacing(10)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
            } else {
                Text("To Do List")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.bottom, -5)
                Divider()
            }
            
            
            ZStack(alignment:.bottomTrailing) {
                
                List {
                    ForEach(sections.section) {section in
                        if let index = indexEditedSection, sections.section[index].id == section.id {
                            
                        
                            HStack(alignment:.bottom) {
                                TextEditor(text: $editedSectionName)

                                    .font(.title)
                                VStack {
                                    
                                    Button("Cancel", role: .destructive) {
                                        editedSectionName = ""
                                        indexEditedSection = nil
                                    }
                                    Button("Accept") {
                                        sections.section[index].name = editedSectionName
                                        editedSectionName = ""
                                        indexEditedSection = nil
                                    }
                                    
                                }
                                .padding(.top, -10)
                                .buttonStyle(BorderlessButtonStyle())
                                .font(.footnote)
                            }
                        } else {
                        Button {
                            withAnimation(.linear) {
                                sectionController.chosenSection =
                                sections.section.firstIndex(where: {$0.id == section.id })!
                                viewController.viewPrisented = .tasksView
                            }
                        } label: {
                            HStack(spacing:10) {
                                
                                Image(systemName:  section.imageLable)
                                
                                Text(section.name)
                            }
                        }
                        .contextMenu {
                            Button {
                                editedSectionName = section.name
                                indexEditedSection = sections.section.firstIndex(where: {$0.id == section.id})
                            } label: {
                                HStack {
                                    Text("Edit")
                                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                }
                            }
                            
                            
                            Button(role: .destructive) {
                                let index = sections.section.firstIndex(where: {$0.id == section.id})!
                                sections.section.remove(at: index)
                                sections.tasks.remove(at: index)
                                sections.historyTasks.remove(at: index)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                        }
                        .padding(3)
                        //                        .buttonStyle(BorderlessButtonStyle())
                        .font(.largeTitle)
                        .foregroundColor(section.sectionStyle.locolToColor())
                        .contrast(2)
                        
                    }
                    }

                }
                
                .padding(.bottom, 20)
                .padding(.top, -8)
                .blur(radius: onAdd ? 1 : 0)
                
                
                
                if onAdd {
                    Rectangle()
                        .fill(Color("StandartColorW"))
                        .padding(.top, -9)
                    //                            .edgesIgnoringSafeArea(.bottom)
                        .opacity(0.1)
                        .animation(.easeIn, value: onAdd)
                        .onTapGesture {
                            onAdd = false
                        }
                }
                
                VStack(alignment: .trailing, spacing: 4) {
                    AddButton(lable: "Section", image: Image(systemName: "text.badge.plus"), action: {viewAddView = true},hide: !onAdd)
                        .padding(.horizontal, 25)
                        .fullScreenCover(isPresented: $viewAddView) {
                            SectionAdd(sections: sections, localColor:
                                        $sectionController.lastColor, localLable: $sectionController.lastIcon)
                            .onAppear(perform: {
                                onAdd = false
                            })
                        }
                    
                    Button {
                        onAdd.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 20,height: 20)
                            .foregroundColor(.black)
                            .padding(25)
                            .background(Color("ButtonColor"))
                            .clipShape(Circle())
                            .padding( 20)
                        
                    }
                    .rotationEffect( .degrees(onAdd ? 315 : 0))
                    .animation(.easeOut, value: onAdd)
                }
                .offset(y:-36)
            }
            
        }
        
    }
    

    
}

struct SectionsView_Previews: PreviewProvider {
    static var previews: some View {
        SectionsView(sections: Sections(),sectionController: SectionController(),viewController: ViewController())
    }
}
