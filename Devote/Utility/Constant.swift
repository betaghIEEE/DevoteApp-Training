//
//  Constant.swift
//  Devote
//
//  Created by Daniel Beatty on 11/12/21.
//

import SwiftUI

//  MARK:   -   FORMATTER

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

let testItem: Item = {
    let item = Item()
    item.id = UUID()
    item.task = ""
    item.completion = false
    return item
}()

//  MARK:   -   UI
var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}



//  MARK:   -   UX

let feedback = UINotificationFeedbackGenerator()
