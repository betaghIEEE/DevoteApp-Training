//
//  ListRowItemView.swift
//  Devote
//
//  Created by Daniel Beatty on 11/14/21.
//

import SwiftUI

struct ListRowItemView: View {
    // MARK: - PROPERTY
    
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Item 
    
    
    
    var body: some View {
        Toggle(isOn: $item.completion){
            Text(item.task ?? "" )
                .font(.system(.title2, design: .rounded))
                .foregroundColor (item.completion ? Color.pink : Color.primary )
                .padding(.vertical, 12)
                .animation(.default )
                
        } //: TOGGLE
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange, perform:{
            try? self.viewContext.save()
        })
        
    }
}

struct ListRowItemView_Previews: PreviewProvider {
    
  
    
    static var previews: some View {
        ListRowItemView(item: testItem)
    }
}
