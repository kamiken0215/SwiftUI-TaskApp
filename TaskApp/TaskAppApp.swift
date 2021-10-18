//
//  TaskAppApp.swift
//  TaskApp
//
//  Created by 神山賢太郎 on 2021/10/18.
//

import SwiftUI

@main
struct TaskAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
