//
//  NewDataView.swift
//  TaskApp
//
//  Created by 神山賢太郎 on 2021/10/18.
//

import SwiftUI

struct NewDataView: View {
    
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            HStack {
                Text("Add New Task")
                    .font(.system(size: 65))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Spacer(minLength: 0)
            }
            .padding()
            
            TextEditor(text: $homeData.content)
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text("When")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack(spacing: 10) {
                DateButton(title: "Today", homeData: homeData)
                DateButton(title: "Tomorrow", homeData: homeData)
                DatePicker("", selection: $homeData.date,displayedComponents: .date)
                    .labelsHidden()
            }
            
            
            Button(action: {homeData.writeData(context: context)}, label: {
                Label(
                    title: { Text(homeData.updateItem == nil ? "Add Now" : "Update")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    },
                    icon: { Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                    })
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width-30)
                    .background(Color.black
                            //LinearGradient(gradient: .init(colors:[Color("Color"),Color("Color1")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
                    
                })
                .padding()
                .disabled(homeData.content == "" ? true : false)
                .opacity(homeData.content == "" ? 0.5 : 1)
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
}
