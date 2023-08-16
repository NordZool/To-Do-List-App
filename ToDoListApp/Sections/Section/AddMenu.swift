//
//  AddMenu.swift
//  hz
//
//  Created by admin on 6.08.23.
//

import SwiftUI

struct AddMenuSection: View {
    let content: [String]
    let lable: String
    @Binding var selected: String
    var body: some View {
        Section {
            ForEach(content, id: \.self) {str in
                Button {
                    selected = str
                } label: {
                        Image(systemName: str)
                }
              
            }
        } header: {
            HStack {
                Spacer()
                Text(lable)
            }
        }
    }
}

