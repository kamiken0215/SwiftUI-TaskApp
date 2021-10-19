//
//  HomeViewModel.swift
//  TaskApp
//
//  Created by 神山賢太郎 on 2021/10/18.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    
    @Published var content = ""
    @Published var date = Date()
    
    @Published var isNewData = false
    @Published var updateItem: Task!
    
    let calendar = Calendar.current
    
    func checkdate () -> String {
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInTomorrow(date) {
            return "Tommorow"
        } else {
            return "Other day"
        }
    }
    
    func updateDate(value: String) {
        if value == "Today" {
            date = Date()
        } else if value == "Tommorow" {
            date = calendar.date(byAdding: .day, value: 1, to: Date())!
        } else {
            
        }
    }
    
    func writeData(context: NSManagedObjectContext) {
        
        if updateItem != nil {
            updateItem.date = date
            updateItem.content = content
            
            try! context.save()
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            date = Date()
            return
        }
        
        let newTask = Task(context: context)
        newTask.date = date
        newTask.content = content
        
        //  saving data
        
        do {
            
            try context.save()
            //  success means closing view...
            isNewData.toggle()
            content = ""
            date = Date()
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editItem(item: Task) {
        updateItem = item
        date = item.date!
        content = item.content!
        isNewData.toggle()
    }

}

