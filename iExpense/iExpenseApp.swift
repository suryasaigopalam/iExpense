//
//  iExpenseApp.swift
//  iExpense
//
//  Created by surya sai on 24/02/24.
//

import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
