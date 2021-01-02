//
//  TodoListVM.swift
//  ToDo
//
//  Created by Godwin  on 30/12/20.
//

import Foundation


protocol TodosListDelegate: AnyObject {
    func reloadData()
}

class TodosListVM {
    
    // MARK: - Properties
    weak var delegate : TodosListDelegate?
    var items = [ToDoModel]()
    var count: Int { return items.count }
    var canSort: Bool { return items.count < 2 }
    var sortType: Categories = .Default
    let sortCategories: [Categories] = [.Priority,.Completed,.Shedule,.Default,.DateCreated,.DateEdited]

    // MARK: - Methods
    func addNew(text: String) {
        let todoItem = ToDoModel(title: text)
        items.insert(todoItem, at: 0)
        sortType = .Default
    }
    
    
    // MARK: - When User Prioritize Task
    func makeImportant(index: Int) {
        
        sortType = .Default
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
    
    // MARK: - When User Complete Task
    func makeComplete(index: Int) {
        
        sortType = .Default
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
    
    // MARK: - To Bring Task Top Of List
    private func findImportantIndex() -> Int? {
        for index in 0..<items.count {
            if items[index].isImportant == true { return index }
        }
        return nil
    }
    
    // MARK: - To put Task Bottom Of List
    private func findCompletedIndex() -> Int? {
        for index in 0..<items.count {
            if items[index].isDone == true { return index }
        }
        return nil
    }
    
    // MARK: - To show Task Items By Selected Categories
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
            list.sort { $0.sheduleTime  > $1.sheduleTime }
        default: print("")
        }
        
        items = list
        sortType = type
        delegate?.reloadData()
    }
    
    // MARK: - To Share selected Item Data to Details Screen
    func prepareDetails(index: Int) -> ToDoModel{
        items[index].index = index
        sortType = .Default
        return items[index]
    }
}
