//
//  AddTextField.swift
//  hz
//
//  Created by admin on 5.08.23.
//

import SwiftUI

struct AddTextField: View {
    @Binding var text: String
    let title: String
    
    var body: some View {
        VStack(spacing:0) {

            ZStack(alignment:.topLeading) {
                if text.isEmpty {
                    Text(title)
                        .foregroundColor(.gray)
                        .offset(x:3,y:12)
                }
                VStack {
                
                    TextEditor(text: $text)
                       
                    //                    .frame(height: 100)
                    //                    .background(.gray)
                        .scrollContentBackground(.hidden)
                        .padding(0)
                 
                }
              
            }
            Rectangle()
                .frame(height:1)
                .padding(.top, -728 + CGFloat(text.filter({$0 == "\n"}).count * 22))
            
        }
        .padding(.horizontal, 10)
    }
}
