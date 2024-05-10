//
//  AddView.swift
//  iExpense
//
//  Created by surya sai on 03/03/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelcontext
    @State var name = ""
    @State var type = "Personal"
    @State var amount = 0.0
    @Environment(\.dismiss) var dismiss
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
                    if name.isEmpty {
                        dismiss()
                        return
                    }
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    modelcontext.insert(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView()
       
}
