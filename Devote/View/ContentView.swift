//
//  ContentView.swift
//  Devote
//
//  Created by Daniel Beatty on 11/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    @State private var task : String  = ""
    
    private var isButtonDisabled : Bool {
        task.isEmpty
    }
    
    @State private var showNewTaskItem : Bool = false
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //  MARK: Functions


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                //  MARK:   - Main View
                VStack {
                    //  MARK:   - HEADER
                    
                    Spacer(minLength: 80)
                    
                    
                    //  MARK:   - New Task Button
                    
                    Button(action: {
                        showNewTaskItem = true
                        
                        }, label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30, weight: .semibold, design: .rounded))
                            Text("New Task")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                    })  //: New Task Button
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                                        .clipShape(Capsule())
                        )
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    
                    
                    
                    //  MARK:   - TASKS
                    
                        List {
                            ForEach(items) { item in
                                VStack(alignment: .leading) {
                                    Text(item.task ?? "")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }   //:     LIST ITEM
                            }
                            .onDelete(perform: deleteItems)
                        }   //: List
                        .listStyle(InsetGroupedListStyle())
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                        .padding(.vertical, 0 )
                        .frame(maxWidth: 640)
                } //:   VSTACK
                
                //  MARK:   - New Task Item
                if showNewTaskItem {
                    BlankView()
                        .onTapGesture {
                            withAnimation(){
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
                
            }//: ZStack
            .onAppear(){
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            .navigationBarTitle("Daily Tasks", displayMode:.large )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }//: TOOLBAR
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
            
        } //: NAVIGATIONVIEW
        .navigationViewStyle(StackNavigationViewStyle())
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
        }
    }
}
