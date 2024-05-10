//
//  ContentView.swift
//  iExpense
//
//  Created by surya sai on 24/02/24.
//

import SwiftUI


struct ContentView: View {
    @State var showingAddExpense = false
    @State var sortOrder = "Name"
    @State var reverseorder = false
    @State var showing = "All"
    var body: some View {
        NavigationStack {
            ExpenseItemsView(sortOrder: sortOrder,reverseorder:reverseorder,showing: showing)
            .navigationTitle("iExpenses")
            .toolbar {
           
                    Button("Add",systemImage: "plus") {
                        showingAddExpense  = true
                    }
                    
                    Menu("Sorting",systemImage: "arrow.up.arrow.down") {
                        Picker("Sort",selection: $sortOrder) {
                            Text("Name")
                                .tag("Name")
                                
                            Text("Price")
                                .tag("Amount")
                               
                        }
                        
                    }
                
                  
                Menu("SortingOrder") {
                    Picker("Sort",selection: $reverseorder) {
                        Text("Low-High")
                            .tag(false)
                            
                        Text("High-Low")
                            .tag(true)
                           
                    }
                    
                }
                Menu("Showing: \(showing)") {
                    Picker("show",selection: $showing) {
                        Text("All")
                            .tag("All")
                        Text("Business")
                            .tag("Business")
                        Text("Personal")
                            .tag("Personal")
                    }
                }
            
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddView()
            })
        }
    }
}

#Preview {
    ContentView()
}
