//
//  Home.swift
//  TaskApp
//
//  Created by 神山賢太郎 on 2021/10/18.
//

import SwiftUI

struct Home: View {
    
    @StateObject var homeDate = HomeViewModel()
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending:true)], animation: .spring()) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            VStack(spacing:0) {
                
                HStack {
                    Text("\(homeDate.updateItem == nil ? "Add New" : "Update") Task")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                //  Empty view
                if results.isEmpty {
                    Spacer()
                    
                    Text("No Tasks !!!")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(results) { task in
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text(task.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text(task.date ?? Date(), style: .date)
                                        .fontWeight(.bold)
                                })
                                .foregroundColor(.black)
                                .contextMenu{
                                    Button(action: {
                                        homeDate.editItem(item: task)
                                    }, label: {
                                        Text("Edit")
                                    })
                                    
                                    Button(action: {
                                        context.delete(task)
                                        try! context.save()
                                    }, label: {
                                        Text("Delete")
                                    })
                                }
                            }
                        }
                        .padding()
                    })
                }
                
                
                Button(action: {homeDate.isNewData.toggle()}, label: {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.black
    //                            AngularGradient(gradient: .init(colors: [Color("color"),Color("Color1")]), center: .center)
                        )
                        .clipShape(Circle())
                    
                })
            }

        })
        .sheet(isPresented: $homeDate.isNewData, content: {
            NewDataView(homeData: homeDate)
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
