//
//  ToDoListVC.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit

class ToDoListVC: UIViewController {

    var todolistTableView = UITableView()
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

        todolistTableView.backgroundColor = .red
    }
    
    private func prepareData() {
        todoItemList.append(ToDoModel())
        todoItemList.append(ToDoModel())
        todoItemList.append(ToDoModel())
        todoItemList.append(ToDoModel())
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




extension UIView {
    
    func prepareLayout(attribute: NSLayoutConstraint.Attribute) {
        
        translatesAutoresizingMaskIntoConstraints = false
        let layout = NSLayoutConstraint(item: self,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: superview,
                                        attribute: attribute,
                                        multiplier: 1,
                                        constant:0)
        NSLayoutConstraint.activate([layout])
    }
    
    
    func prepareHeight(constant: CGFloat) {
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant)
        NSLayoutConstraint.activate([constraint])
    }
}
