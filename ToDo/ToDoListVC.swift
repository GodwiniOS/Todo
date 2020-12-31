//
//  ToDoListVC.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit

class ToDoListVC: UIViewController {

    var todolistTableView = UITableView()
    var addTaskButton = UIButton()
    var todoItemList = TodosList()

    override func viewDidLayoutSubviews() {
        prepareView()
    }

    private func prepareView() {
        
        title = "To Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(sortTapped))

        
        view.addSubview(todolistTableView)
        
        // prepare ListTable
        todolistTableView.prepareLayout(.top)
        todolistTableView.prepareLayout(.bottom)
        todolistTableView.prepareLayout(.leading)
        todolistTableView.prepareLayout(.trailing)
        todolistTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        todolistTableView.delegate = self
        todolistTableView.dataSource = self
        todolistTableView.separatorStyle = .none

        
        
        view.addSubview(addTaskButton)
        
        // prepare ListTable
        addTaskButton.prepareLayout(.bottom,constant: -10)
        addTaskButton.prepareLayout(.leading,constant: 10)
        addTaskButton.prepareLayout(.trailing,constant: -10)
        addTaskButton.prepareHeight(constant: 60)
        addTaskButton.backgroundColor = .black
        addTaskButton.cornerRadius(constant: 10, color: .lightGray)
        addTaskButton.setTitle("Add New", for: .normal)
        addTaskButton.addTarget(self, action: #selector(pressed),
                                for: .touchUpInside)
        
        
        todoItemList.delegate = self
    }
    

    
    @objc func sortTapped() {

        let categories: [Categories] = [.dateCreated,.dateEdited,.priority,.completed,.shedule,.normal]
        
        let actionSheetController = UIAlertController(title: "Sort Task",
                                                      message: nil,
                                                      preferredStyle: .actionSheet)

        
        for type in categories {
            let style : UIAlertAction.Style = type == .normal ? .cancel : .default
            let action = UIAlertAction(title: type.rawValue,
                                       style:style ) { action -> Void in
                guard type != .normal else { return }
                self.todoItemList.sortList(by: type)
            }
            action.prepare()
            actionSheetController.addAction(action)
        }
    
        actionSheetController.popoverPresentationController?.sourceView = todolistTableView
        
        present(actionSheetController, animated: true)
    }
    
    @objc func pressed() {
        
        let ac = UIAlertController(title: "Enter answer",
                                   message: nil,
                                   preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            guard let text = ac.textFields![0].text,!text.isEmpty else {
                return
            }
            self.todoItemList.addNew(text: text)
            self.reloadTabe()
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func reloadTabe(){
        UIView.transition(with: todolistTableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: { self.todolistTableView.reloadData() })
    }
}


extension ToDoListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoItemList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItemTVC = ToDoTableViewCell()
        todoItemTVC.prepareTableViewCell()
        todoItemTVC.delegate = self
        todoItemTVC.prepareData(todoItem: todoItemList.items[indexPath.row], index: indexPath.row)
        return todoItemTVC
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ItemDetailsVC(), animated: true)
    }
}



extension ToDoListVC: ToDoTVCDelegate {
    func completeButtonClicked(index: Int) {
        todoItemList.complete(index: index)
        reloadTabe()
    }
    
    func importantButtonClicked(index: Int) {
        todoItemList.importantTodo(index: index)
        reloadTabe()
    }
}


extension ToDoListVC: kkk {
    func kkk() {
        reloadTabe()
    }
}
