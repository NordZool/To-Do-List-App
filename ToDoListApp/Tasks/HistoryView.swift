//
//  HistoryView.swift
//  hz
//
//  Created by admin on 2.08.23.
//

import SwiftUI

struct HistoryView: View {
    @Binding var histTasks: [Task]
    @Environment (\.dismiss) var dismiss
    var selected: Int?
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 75,height: 10)
                .onTapGesture {
                    dismiss.callAsFunction() //сделать чтобы задвигало только по нажадить или только жту область сделать длч подвижного dissmis'а
                }
            Spacer()
            if !histTasks.isEmpty {
                List {
                    ForEach(histTasks) {task in
                        VStack(alignment: .leading) {
                            Text(task.name)
                            Text( "Done at: " + task.doneTime!)
                                .font(.footnote)
                                .foregroundColor(.gray)
//                                .offset(y:15)
                        }
                    }
                }
            } else {
                Text("""
Not found history on this section.
maybe you were looking forthe history
 of another section?
🤔
""")
                .multilineTextAlignment(.center)
            }
            Spacer()
        }
    }
}

