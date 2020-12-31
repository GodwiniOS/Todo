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
    var todoItemList = [ToDoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
    
    override func viewDidLayoutSubviews() {
        prepareView()
    }

    private func prepareView() {
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
        addTaskButton.setTitle("dejdj", for: .normal)
        addTaskButton.addTarget(self, action: #selector(pressed),
                                for: .touchUpInside)
    }
    
    private func prepareData() {
        todoItemList.append(ToDoModel())
        todoItemList.append(ToDoModel())
        todoItemList.append(ToDoModel())
        todoItemList.append(ToDoModel())
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
            self.addTask(text: text)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    private func addTask(text: String) {
        let todoItem = ToDoModel(title: text)
        todoItemList.insert(todoItem, at: 0)
        todolistTableView.reloadData()
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
        todoItemTVC.prepareData(todoItem: todoItemList[indexPath.row], index: indexPath.row)
        return todoItemTVC
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}



extension ToDoListVC: ToDoTVCDelegate {
    func completeButtonClicked(index: Int) {
        todoItemList[index].isDone = !todoItemList[index].isDone
        todolistTableView.reloadData()

    }
    
    func importantButtonClicked(index: Int) {
        todoItemList[index].isImportant = !todoItemList[index].isImportant
        todolistTableView.reloadData()
    }
}
