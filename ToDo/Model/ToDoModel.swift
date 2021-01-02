//
//  ToDoModel.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import Foundation

struct ToDoModel {
    
    var title: String
    var index: Int?

    var isDone: Bool = false
    var isSheduled: Bool = false
    var isImportant: Bool = false

    var createdTime: Date = Date()
    var sheduleTime: Date = Date()
    var lastEditedTime: Date = Date()
    
    mutating func saveChanges(of item: ToDoModel){
        
        isSheduled = item.isSheduled
        isDone = item.isDone
        isImportant = item.isImportant
        title = item.title
        sheduleTime = item.sheduleTime
        lastEditedTime = Date()
        index = nil
    }
}
