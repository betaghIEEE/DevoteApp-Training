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
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool  = false
    
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
                    
                    HStack(spacing: 10) {
                        
                        //  TITLE "Daily Tasks"
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        //  EDIT BUTTON
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2 )
                            )
                        
                        //  APPEARANCE
                        
                        Button(
                            action:{
                                // Flip flop dark-light mode
                                isDarkMode.toggle()
                                playSound(sound: "sound-tap", type: "mp3")
                                
                            }, label: {
                                Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle" )
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .font(.system(.title, design: .rounded))
                            }
                        )
                        
                    } //:   HSTACK
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    
                    
                    //  MARK:   - New Task Button
                    
                    Button(action: {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        
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
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    /*
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
                     */
                        .listStyle(InsetGroupedListStyle())
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                        .padding(.vertical, 0 )
                        .frame(maxWidth: 640)
                } //:   VSTACK
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false )
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                //  MARK:   - New Task Item
                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? Color.black : Color.gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5)
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
            .navigationBarHidden(true)
            .background(BackgroundImageView()
                            .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false  ))
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
