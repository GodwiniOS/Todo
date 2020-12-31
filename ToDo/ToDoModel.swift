//
//  ToDoModel.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import Foundation

struct ToDoModel {
    
    var title: String = "New"
    var subtitle: String = "New"
    var isDone: Bool = false
    var isImportant: Bool = false
    var createdTime: Date = Date()
    var lastEditedTime: Date = Date()
    
}
