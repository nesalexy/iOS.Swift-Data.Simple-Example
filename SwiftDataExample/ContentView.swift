//
//  ContentView.swift
//  SwiftDataExample
//
//  Created by Alexy Nesterchuk on 08.07.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @State private var expenseToEdit: Expense?
    
    @Query(sort: \Expense.date) var expenses: [Expense]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                            expenseToEdit = expense
                        }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        context.delete(expenses[index])
                        /// try! context.save()
                    }
                })
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet, content: {
                AddExpenseSheet()
            })
            .sheet(item: $expenseToEdit) { expense in
                UpdateExpenseSheet(expense: expense)
            }
            .toolbar {
                if !expenses.isEmpty {
                    Button {
                        isShowingItemSheet.toggle()
                    } label: {
                        Text("+")
                    }
                }
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView {
                        Label("No Expenses", systemImage: "glob")
                    } description: {
                        Text("Start adding expenses to see your list.")
                    } actions: {
                        Button("Add Expenses") {
                            isShowingItemSheet.toggle()
                        }
                    }
                    .offset(y: -60)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
