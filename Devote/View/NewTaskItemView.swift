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
    
    @Binding var isShowing: Bool
    
    
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
            isShowing = false
        }
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            
                VStack(spacing: 16)  {
                    TextField("New Task", text: $task)
                        .foregroundColor(.pink)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
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
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Spacer()
                    })
                        .disabled(isButtonDisabled)
                        .padding()
                        .foregroundColor(.white)
                        .background(isButtonDisabled ? Color.blue : Color.pink)
                        .cornerRadius(10)
                    
                }   //: VSTACK - Edit View
                .padding(.horizontal)
                .padding(.vertical,  20)
                .background(
                    Color(.white)
                )
                .cornerRadius(16)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
                .frame(maxWidth: 640)
        } //:   VStack End
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .previewDevice("iPhone 12 Pro")
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
