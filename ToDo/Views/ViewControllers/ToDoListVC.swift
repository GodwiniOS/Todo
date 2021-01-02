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
    
    override func viewWillAppear(_ animated: Bool) {
        prepareView()
        reloadTable()
    }

    private func prepareView() {
        
        let barButton = UIBarButtonItem(title: "Sort",
                                        style: .plain,
                                        target: self,
                                        action: #selector(sortTapped))

        navigationItem.rightBarButtonItem = barButton
        prepareBarButton()
        todoListVM.delegate = self
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
        addTaskButton.addTarget(self, action: #selector(addTaskAction),
                                for: .touchUpInside)
        }
    

    
    @objc func sortTapped() {


        if todoListVM.canSort  {

            let alert = UIAlertController(title: "List Empty", message: "Add more than one tasks to catgories tasks", preferredStyle: UIAlertController.Style.alert)

            let addNew = UIAlertAction(title: "Add New", style: .default, handler: { (action: UIAlertAction!) in
                self.addTaskAction()
            })
            addNew.prepare()
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in })
            cancel.prepare(color: .red)

            alert.addAction(addNew)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            return
        }

        let actionSheetController = UIAlertController(title: "Select Category",
                                                      message: "Sorting List Items by Selected Category",
                                                      preferredStyle: .actionSheet)

        
        for category in todoListVM.sortCategories {
            let style : UIAlertAction.Style = category == .Normal ? .cancel : .default
            let action = UIAlertAction(title: category.rawValue,
                                       style:style ) { action -> Void in
                guard category != .Normal else { return }
                self.todoListVM.sortList(by: category)
            }
            action.prepare()
            actionSheetController.addAction(action)
        }
    
        actionSheetController.popoverPresentationController?.sourceView = todolistTableView
        
        present(actionSheetController, animated: true)
    }
    
    @objc func addTaskAction() {
        
        let ac = UIAlertController(title: "Task Name",
                                   message: nil,
                                   preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned ac] _ in
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

        if todoListVM.sortType != .Normal{
            navigationItem.rightBarButtonItem?.title = "Category - " + todoListVM.sortType.rawValue
        } else {
            navigationItem.rightBarButtonItem?.title = "Category"
        }
        
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
        todoListVM.sortType = .Normal
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
