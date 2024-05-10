//
//  ExpenseItemsView.swift
//  iExpense
//
//  Created by surya sai on 10/05/24.
//

import SwiftUI
import SwiftData

struct ExpenseItemsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenseItems:[ExpenseItem]
    var body: some View {
        NavigationStack {
            Form {
                ForEach(expenseItems) { item in
            
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
                    for offset in indexSet {
                        let book = expenseItems[offset]
                        modelContext.delete(book)
                    }
                })
           
            }
        }
    }
    init(sortOrder:String,reverseorder:Bool,showing:String) {
        var order:[SortDescriptor<ExpenseItem>]
        let filter = #Predicate<ExpenseItem>{ user in
            if showing == "Personal" {
                user.type == "Personal"
            }
            else if showing == "Business" {
               user.type == "Business"
            }
            else {
                true
            }
            
            }
        
        if sortOrder == "Name" {
            order = [SortDescriptor<ExpenseItem>(\.name, order: reverseorder ? .reverse:.forward)]
        }
        else {
            order = [SortDescriptor<ExpenseItem>(\.amount, order: reverseorder ? .reverse:.forward)]
        }
        _expenseItems = Query(filter: filter, sort:order, animation: .default)
       
    }
}

#Preview {
    ExpenseItemsView(sortOrder: "Name",reverseorder: false,showing: "All")
}
