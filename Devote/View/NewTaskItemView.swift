//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Daniel Beatty on 11/13/21.
//

import SwiftUI

struct NewTaskItemView: View {
    
    // MARK: - PROPERTY
    @State private var task : String  = ""
    
    private var isButtonDisabled : Bool {
        task.isEmpty
    }
    
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    
    //  MARK: Functions
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
        }
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            
                VStack(spacing: 16)  {
                    TextField("New Task", text: $task)
                        .padding()
                        .background(
                            Color(UIColor.systemGray6)
                        )
                        .cornerRadius(10)
                        
                    
                    Button(action: {
                        addItem()
                    }, label: {
                        Spacer()
                        Text("SAVE")
                        Spacer()
                    })
                        .disabled(isButtonDisabled)
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(isButtonDisabled ? Color.gray : Color.pink)
                        .cornerRadius(10)
                    
                }   //: VSTACK - Edit View
                .padding()
        } //:   VStack End
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView()
            .previewDevice("iPhone 12 Pro")
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
