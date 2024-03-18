//
//  AddView.swift
//  iExpense
//
//  Created by surya sai on 03/03/24.
//

import SwiftUI

struct AddView: View {
    @State var expenses:Expenses
    @State var name = ""
    @State var type = "Personal"
    @State var amount = 0.0
    @Binding var dismiss:Bool
    var types = ["Business","Personal"]
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name",text: $name)
                Picker("Type",selection: $type) {
                    ForEach(types,id: \.self) {
                        Text($0)
                    
                    }
                }
                TextField("Amount",value:$amount,format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss = false
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses(), dismiss: .constant(true))
}
