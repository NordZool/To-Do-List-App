//
//  AddButton.swift
//  hz
//
//  Created by admin on 30.07.23.
//

import SwiftUI

struct AddButton: View {
    let lable: String
    let image: Image
    
    let action: () -> Void
    let hide: Bool
    var body: some View {
        
        HStack(spacing: 20) {
            Text(lable)
                .opacity(hide ? 0 : 1)
                .animation(.easeIn, value: hide)
            
            Button(action: {
                action()
            }, label: {
                image
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35,height: 35)
                .foregroundColor(.black)
                .padding(10)
                .background(Color("ButtonColor"))
                .clipShape(Circle())
            })
            .scaleEffect(hide ? 0 : 1)
            .opacity(hide ? 0 : 1)
                            .animation(.spring(), value: hide)
            
            
            //                Button {
            //                    action()
            //                } label: {
            //                    image
            //                        .renderingMode(.original)
            //                        .resizable()
            //                        .aspectRatio(contentMode: .fit)
            //                        .frame(width: 35,height: 35)
            //                        .foregroundColor(.black)
            //                        .padding(10)
            //                        .background(Color("ButtonColor"))
            //                        .clipShape(Circle())
            //                }
            //                //            .opacity(hide ? 0 : 1)
            //                .scaleEffect(hide ? 0 : 1)
            //                .animation(.spring(), value: hide)
            
            
        }
        
    }
}


fileprivate struct testNavigation :View {
    var body: some View {
        NavigationView {
            Text("Test")
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(lable: "test", image: Image(systemName: "apple.logo"), action: {},hide: false)
    }
}
