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
    
    @ObservedObject var sections: Sections
    @ObservedObject var sectionController: SectionController
    @ObservedObject var viewController: ViewController
    var body: some View {
        NavigationView {
            
            VStack {
                Divider()
                ZStack(alignment:.bottomTrailing) {
                    List {
                        ForEach(sections.section) {section in
                            Button {
                                sectionController.chosenSection =
                                sections.section.firstIndex(where: {$0.id == section.id })!
                                viewController.viewPrisented = .tasksView
                            } label: {
                                HStack(spacing:10) {
                                    
                                    Image(systemName:  section.imageLable)
                                    
                                    Text(section.name)
                            }

                          
//                                    Spacer()
////                                Button {
////
////                                } label: {
////                                    Image(systemName: "chevron.right")
////                                }
////                                .padding()
////                                .buttonStyle(BorderlessButtonStyle())

                            }
                         
                            .listRowBackground(section.id == sections.section[sectionController.chosenSection].id ?
                                               Color.blue.opacity(0.5) : Color("StandartColorW")) //временно для теста time
                          
                            .font(.largeTitle)
                            .foregroundColor(section.sectionStyle.locolToColor())
                            .contrast(2)
                        }
                    }
                    
                    .padding(.top, -8)
                    .blur(radius: onAdd ? 1 : 0)
                    
                    if onAdd {
                        Rectangle()
                            .fill(Color("StandartColorW"))
                            .padding(.top, -9)
                            .edgesIgnoringSafeArea(.bottom)
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
                }
            }
            .navigationTitle("Sections")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    
}

struct SectionsView_Previews: PreviewProvider {
    static var previews: some View {
        SectionsView(sections: Sections(),sectionController: SectionController(),viewController: ViewController())
    }
}
