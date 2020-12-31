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
        addTaskButton.backgroundColor = .lightGray
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
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            // do something interesting with "answer" here
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
        return todoItemTVC
    }
}




