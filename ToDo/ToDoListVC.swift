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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
    
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
        todolistTableView.prepareLayout(attribute: .top)
        todolistTableView.prepareLayout(attribute: .bottom)
        todolistTableView.prepareLayout(attribute: .leading)
        todolistTableView.prepareLayout(attribute: .trailing)
        todolistTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        todolistTableView.delegate = self
        todolistTableView.dataSource = self
        todolistTableView.separatorStyle = .none

        
        
        view.addSubview(addTaskButton)
        
        // prepare ListTable
        addTaskButton.prepareLayout(attribute: .bottom,
                                    constant: -10)
        addTaskButton.prepareLayout(attribute: .leading,
                                    constant: 10)
        addTaskButton.prepareLayout(attribute: .trailing,
                                    constant: -10)
        addTaskButton.prepareHeight(constant: 60)
        addTaskButton.backgroundColor = .black
        addTaskButton.cornerRadius(constant: 10, color: .lightGray)
        addTaskButton.setTitle("Add New", for: .normal)
        addTaskButton.addTarget(self, action: #selector(pressed),
                                for: .touchUpInside)
    }
    
    private func prepareData() {
//        todoItemList.append(ToDoModel())
//        todoItemList.append(ToDoModel())
//        todoItemList.append(ToDoModel())
//        todoItemList.append(ToDoModel())
    }
    
    @objc func sortTapped() {

        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let firstAction: UIAlertAction = UIAlertAction(title: "First Action", style: .default) { action -> Void in
        }

        let secondAction: UIAlertAction = UIAlertAction(title: "Second Action", style: .default) { action -> Void in
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }

        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        actionSheetController.popoverPresentationController?.sourceView = todolistTableView

//        present(actionSheetController, animated: true) {
//            print("option menu presented")
//        }
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
            self.todolistTableView.reloadData()
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}


extension ToDoListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        todolistTableView.reloadData()

    }
    
    func importantButtonClicked(index: Int) {
        todoItemList.importantTodo(index: index)
        todolistTableView.reloadData()
    }
}
