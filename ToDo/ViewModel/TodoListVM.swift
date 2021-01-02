//
//  TodoListVM.swift
//  ToDo
//
//  Created by Godwin  on 02/01/21.
//

import Foundation


protocol TodosListDelegate: AnyObject {
    func reloadData()
}

class TodosListVM {
    
    weak var delegate : TodosListDelegate?
    var items = [ToDoModel]()
    var count: Int { return items.count }
    var isEmpty: Bool { return items.isEmpty }
    var sortType: Categories = .Normal
    
    func addNew(text: String) {
        let todoItem = ToDoModel(title: text)
        items.insert(todoItem, at: 0)
        sortType = .Normal
    }
    
    func makeImportant(index: Int) {
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
    
    func makeComplete(index: Int) {
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
        case .DateCreated:
            list.sort { $0.createdTime < $1.createdTime }
        case .DateEdited:
            list.sort { $0.lastEditedTime > $1.lastEditedTime }
        case .Completed:
            list.sort { $0.isDone && !$1.isDone }
        case .Priority:
            list.sort { $0.isImportant && !$1.isImportant }
        case .Shedule:
            list.sort { $0.sheduleTime  < $1.sheduleTime }
        default: print("")
        }
        
        items = list
        sortType = type
        delegate?.reloadData()
    }
}
