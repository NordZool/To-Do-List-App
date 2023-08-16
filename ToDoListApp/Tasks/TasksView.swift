//
//  TasksView.swift
//  hz
//
//  Created by admin on 1.08.23.
//
import SwiftUI

struct TasksView : View {
//    @ObservedObject var sections: Sections
    @Binding var tasks: [Task]
    @Binding var historyTasks: [Task]
    @Binding var sectionName: String
    let sectionSelect: Bool
    
    @State private var isHistory = false
    
    //add states
    @State private var isAdd = false
    @State private var chekmarkDelay: CGFloat = 0.2
    @State private var addText = ""

    var body: some View {
        NavigationView {
            if sectionSelect {
                List {
                    HStack {
                        
                            ZStack(alignment: .leading) {
                                if addText.isEmpty {
                                    Text(SingletonAssets.catchyPhrases.randomElement()!)
                                        .foregroundColor(.gray)
                                        .offset(y:-10)
                                        
                                }
                                
                                    TextEditor(text: $addText)
                                        .frame(width:250)
                                        .offset(x:-5)
                            }
                            .opacity(isAdd ? 1 : 0)
                            .animation(.linear(duration: 0.1).delay(chekmarkDelay),value: isAdd)
                            .padding(.trailing, -250)
                            .padding(.bottom, -23 )
                        
                        
                        VStack {
                            if addText.contains("\n") {
                                Spacer()
                            }
                            Button {
                               
                                    let newTask = Task(name: addText, createTime: timeNow())
                                    withAnimation(.linear(duration: 0.2)) {
                                        tasks.insert(newTask, at: 0)
                                    }
                                    addText = ""
                                
                               
                            } label: {
                                Image(systemName: "checkmark")
                            }
                            .foregroundColor(.green)
                            .buttonStyle(BorderlessButtonStyle())
                            .opacity(isAdd ? 1 : 0)
                            .animation(.linear(duration: 0.1).delay(chekmarkDelay),value: isAdd)
                            .offset(x:200)
                            .scaleEffect(1.5)
//                            .padding(0)
                        }
                        
                        VStack {
                            if addText.contains("\n") {
                                Spacer()
                            }
                                
                            Button {
                                isAdd.toggle()
                                if chekmarkDelay == 0.2 {
                                    chekmarkDelay = 0.8
                                } else {
                                    chekmarkDelay = 0.2
                                }
                                addText = ""
                            } label: {
                                Image(systemName: "plus")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .foregroundColor(isAdd ? Color.red : Color.blue)
                            .rotationEffect(.degrees(isAdd ? 315 : 0))
                            .offset(x:isAdd ? 160 : -20)
                            .animation(.easeInOut(duration: 1), value: isAdd) //off set лагает с rotstion(меняются оси
                            .scaleEffect(1.5)
//                            .padding(.bottom, addText.contains("\n") ? 23 : 0)
                           
                        }
                          
                        
                        
                        
                    }
                    
                    

                    ForEach(tasks) {task in
                        HStack(alignment:.top) {
                            VStack(alignment:.leading) {
                                Text(task.name)
                                
                                Text( "Create at: " + (task.createTime ?? "error"))
                                    .font(.footnote)
                                    .foregroundColor(Color.gray)
                                    .offset(y:21)
                                
                                
                            }
                            Spacer()
                            HStack(spacing:25) {
//                                Button {
//                                    var task = task
//                                    task.done = false
//                                    historyTasks.insert(task, at: 0)
//                                    tasks.remove(at: tasks.firstIndex(where: {$0.createTime ?? "" == task.createTime ?? ""}) ?? 0)
//                                } label: {
//                                    Image(systemName: "plus.diamond")
//                                        .rotationEffect(.degrees(45))
//                                        .foregroundColor(.red)
//                                        .scaleEffect(2 + CGFloat(task.name.filter{$0 == "\n"}.count) / 2)
//
//                                }
//                                .buttonStyle(BorderlessButtonStyle())
                                
                                Button {
                                    var task = task
                                    task.done = true
                                    task.doneTime = timeNow()
                                    
                                    let createTime = task.createTime
                                    task.createTime = nil
                                    historyTasks.insert(task, at: 0)
                                    withAnimation(.linear) {
                                        tasks.remove(at: tasks.firstIndex(where: {($0.createTime ?? "" == createTime ?? "") &&
                                            task.name == $0.name
                                        }) ?? 0)
                                    }
                                } label: {
                                    let entercount = CGFloat(task.name.filter{$0 == "\n"}.count / 2)
                                    let scale = entercount > 2 ? 2 : entercount
                                    
                                    
                                    Image(systemName: "checkmark.square")
                                        .foregroundColor(.green)
                                        .scaleEffect(2 + scale)
                                        .padding(.top,15 + 10 * scale)
                                        .padding(.trailing, 5 + 10 * scale)
                                    
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }.offset(x:2,y:-20)
                        }.padding(.vertical, 15)
                        
                    }.onDelete(perform: {tasks.remove(atOffsets: $0)})
                    
                    
             
                       
                            
                    
                }
                .navigationTitle(sectionName)
//                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button {
//                            //
//                        } label: {
//                            Text("+ Add task")
//
//
//
//
//                        }
//
//                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isHistory = true
                        } label: {
                            Image(systemName: "clock.arrow.circlepath")
                        }
                        .sheet(isPresented: $isHistory) {
                            HistoryView(histTasks: $historyTasks).cornerRadius(20) //иза этой параши и пашит хз почему
                        }
                        
                    }
                }
            } else {
                VStack {
                    Text("Not found section")
                    Button("test plus") {
                        tasks.insert(Task(name: "clowfdfdn", createTime: timeNow()), at: 0)
                        
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            
        }
        
    }
    func timeNow() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        dateFormat.timeStyle = .medium
        return dateFormat.string(from: Date())
    }
}

////////////////////////////////////////////////////////////////////

fileprivate struct Test : View {
    @ObservedObject var sections = Sections(section: [TaskSection.init(imageLable: "apple.image", name: "test", sectionStyle: .blue)], tasks: [[]], historyTasks: [[]])
    var body: some View {
        TasksView(tasks: $sections.tasks[0], historyTasks: $sections.historyTasks[0], sectionName: $sections.section[0].name,sectionSelect: true)
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
