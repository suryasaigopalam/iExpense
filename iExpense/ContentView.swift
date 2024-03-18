//
//  ContentView.swift
//  iExpense
//
//  Created by surya sai on 24/02/24.
//

import SwiftUI
struct ExpenseItem:Identifiable,Codable {
    var id = UUID()
    let name:String
    let type:String
    let amount:Double
}
@Observable
class Expenses {
    var items:[ExpenseItem] = [] {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(data, forKey: "Items")
                
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try?  JSONDecoder().decode([ExpenseItem].self, from: data) {
                items = decodedItems
            }
        }
    }
}
struct ContentView: View {
  @State var expenses = Expenses()
    @State var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach(expenses.items) { item in
            
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount,format:.currency(code: "USD"))
                    }
                }
                .onDelete(perform: { indexSet in
                    expenses.items.remove(atOffsets: indexSet)
                })
           
            }
            .navigationTitle("iExpenses")
            .toolbar {
                Button("Add",systemImage: "plus") {
                    showingAddExpense  = true
                }
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: expenses,dismiss: $showingAddExpense)
            })
        }
    }
}

#Preview {
    ContentView()
}
