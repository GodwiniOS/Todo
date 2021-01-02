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
    var todoListVM = TodosListVM()
    let barButton = UIBarButtonItem(title: "Sort",
                                    style: .plain,
                                    target: self,
                                    action: #selector(sortTapped))
    
    override func viewDidLayoutSubviews() {
        prepareView()
    }

    private func prepareView() {
        
        title = AppTitle.listVCTitle.rawValue
        todoListVM.delegate = self

        navigationItem.rightBarButtonItem = barButton
        navigationItem.rightBarButtonItem?.tintColor = .black

        // prepare ListTable
        view.addSubview(todolistTableView)
        todolistTableView.prepareLayout(.top)
        todolistTableView.prepareLayout(.bottom,constant: -80)
        todolistTableView.prepareLayout(.leading)
        todolistTableView.prepareLayout(.trailing)
        todolistTableView.registerCell()
        todolistTableView.delegate = self
        todolistTableView.dataSource = self
        todolistTableView.separatorStyle = .none
        
        // prepare ListTable
        view.addSubview(addTaskButton)
        addTaskButton.prepareLayout(.bottom,constant: -20)
        addTaskButton.prepareLayout(.leading,constant: 10)
        addTaskButton.prepareLayout(.trailing,constant: -10)
        addTaskButton.prepareHeight(constant: 60)
        addTaskButton.backgroundColor = .black
        addTaskButton.cornerRadius(color: .lightGray)
        addTaskButton.setTitle(.addNew)
        addTaskButton.addTarget(self, action: #selector(pressed),
                                for: .touchUpInside)
        }
    

    
    @objc func sortTapped() {

        let categories: [Categories] = [.DateCreated,.DateEdited,.Priority,.Completed,.Shedule,.Normal]
        
        let actionSheetController = UIAlertController(title: "Sort Task",
                                                      message: nil,
                                                      preferredStyle: .actionSheet)

        
        for type in categories {
            let style : UIAlertAction.Style = type == .Normal ? .cancel : .default
            let action = UIAlertAction(title: type.rawValue,
                                       style:style ) { action -> Void in
                guard type != .Normal else { return }
                self.todoListVM.sortList(by: type)
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
            self.todoListVM.addNew(text: text)
            self.reloadTable()
        }
        submitAction.setValue(UIColor.black, forKey: "titleTextColor")
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func reloadTable(animation: Bool = true){

        navigationItem.rightBarButtonItem = todoListVM.isEmpty ? nil : barButton

        guard animation else {
            todolistTableView.reloadData()
            return
        }
        UIView.transition(with: todolistTableView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.todolistTableView.reloadData() })
    }
}


extension ToDoListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoListVM.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItemTVC = ToDoTableViewCell()
        todoItemTVC.prepareTableViewCell()
        todoItemTVC.delegate = self
        todoItemTVC.prepareData(todoItem: todoListVM.items[indexPath.row], index: indexPath.row)
        return todoItemTVC
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailsVC()
        todoListVM.items[indexPath.row].index = indexPath.row
        vc.todoItem = todoListVM.items[indexPath.row]
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ToDoListVC: ToDoTVCDelegate {
    func completeButtonClicked(index: Int) {
        todoListVM.makeComplete(index: index)
        reloadTable()
    }
    
    func importantButtonClicked(index: Int) {
        todoListVM.makeImportant(index: index)
        reloadTable()
    }
}


extension ToDoListVC: TodosListDelegate {
    func reloadData() {
        reloadTable(animation: false)
    }
}


extension ToDoListVC: DetailsVCDelegate {
    
    func delete(item: ToDoModel) {
        guard let index = item.index else { return }
        todoListVM.items.remove(at: index)
        reloadTable(animation: false)
    }
    
    func saveChanges(item: ToDoModel) {
        guard let index = item.index else { return }
        todoListVM.items[index].saveChanges(of: item)
        reloadTable()
    }
}
