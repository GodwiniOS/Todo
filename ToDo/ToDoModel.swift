//
//  ToDoModel.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import Foundation

struct ToDoModel {
    
    var title: String
    var isDone: Bool = false
    var isImportant: Bool = false
    var isSheduled: Bool = false
    
    var createdTime: Date = Date()
    var lastEditedTime: Date = Date()
    var sheduleTime: Date = Date()
    var index: Int?
}

enum Categories: String {
    case dateCreated = "Created"
    case dateEdited = "Last Edited"
    case priority = "Important"
    case completed = "Completed"
    case shedule = "Shedule"
    case normal = "Cancel"
}

protocol kkk: AnyObject {
    func kkk()
}

class TodosList {
    
    weak var delegate : kkk?
    var items = [ToDoModel]()
    var count: Int { return items.count }
    var sortType: Categories = .normal
    
    func addNew(text: String) {
        let todoItem = ToDoModel(title: text)
        items.insert(todoItem, at: 0)
        sortType = .normal
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
    
    private func findImportantIndex() -> Int? {
        for index in 0..<items.count {
            if items[index].isImportant == true { return index }
        }
        return nil
    }
    
    private func findCompletedIndex() -> Int? {
        for index in 0..<items.count {
            if items[index].isDone == true { return index }
        }
        return nil
    }
    
    func sortList(by type:Categories) {
        var list = items
        switch type{
        case .dateCreated:
            list.sort { $0.createdTime < $1.createdTime }
        case .dateEdited:
            list.sort { $0.lastEditedTime > $1.lastEditedTime }
        case .completed:
            list.sort { $0.isDone && !$1.isDone }
        case .priority:
            list.sort { $0.isImportant && !$1.isImportant }
        case .shedule:
            list.sort { $0.sheduleTime  < $1.sheduleTime }
        default: print("")
        }
        
        items = list
        sortType = type
        delegate?.kkk()
    }
    
    
    func saveChanges(of item: ToDoModel,index: Int){
        items[index].isSheduled = item.isSheduled
        items[index].isDone = item.isDone
        items[index].isImportant = item.isImportant
        items[index].title = item.title
        items[index].sheduleTime = item.sheduleTime
        items[index].lastEditedTime = Date()
        items[index].index = nil
    }
}
