//
//  ToDoModel.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import Foundation

struct ToDoModel {
    
    var title: String
    var subtitle: String = ""
    var isDone: Bool = false
    var isImportant: Bool = false
    var createdTime: Date = Date()
    var lastEditedTime: Date = Date()
    var sheduleTime: Date?

}

enum Categories: String {
    case dateCreated = "Created"
    case dateEdited = "Last Edited"
    case priority = "Important"
    case completed = "Completed"
    case shedule = "Shedule"
}

class TodosList {
    
    var items = [ToDoModel]()
    var count: Int {
        return items.count
    }
    
    func addNew(text: String) {
        let todoItem = ToDoModel(title: text)
        items.insert(todoItem, at: 0)
        print(todoItem)
    }
    
    func importantTodo(index: Int) {
        var item = items[index]
        if item.isImportant {
            items[index].isImportant = false
            items[index].lastEditedTime = Date()
        } else {
            item.isImportant = true
            item.lastEditedTime = Date()
            items.remove(at: index)
            items.insert(item, at: findImportantIndex() ?? 0)
        }
        
    }
    
    func complete(index: Int) {
        var item = items[index]
        if item.isDone {
            items[index].isDone = false
            items[index].lastEditedTime = Date()

        } else {
            item.isDone = true
            item.lastEditedTime = Date()
            items.remove(at: index)
            items.insert(item, at: findCompletedIndex() ?? count)
        }
    }
    
    func findImportantIndex() -> Int? {
        for index in 0..<items.count {
            if items[index].isImportant == true { return index }
        }
        return nil
    }
    
    func findCompletedIndex() -> Int? {
        for index in 0..<items.count {
            if items[index].isDone == true { return index }
        }
        return nil
    }
    
    func sortList(by type:Categories) {
        switch type{
        case .dateCreated:
            print("dfkjdfkjk")
        default:
            print("dfkjdfkjk")
        }
    }
}
