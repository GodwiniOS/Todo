//
//  ItemDetailsVC.swift
//  ToDo
//
//  Created by Godwin  on 30/12/20.
//

import UIKit

protocol DetailsVCDelegate: AnyObject {
    func saveChanges(item: ToDoModel)
    func delete(item: ToDoModel)
}


class TaskDetailsVC: UIViewController{

    
    // MARK: - Properties
    let backgroundView = UIView()
    let createdLabel = UILabel()
    let sheduleLabel = UILabel()
    let lastEditedLabel = UILabel()
    let titleText = TextField()
    let datePicker = UIDatePicker()
    let deletebutton = UIButton()
    let sheduleButton = UIButton()
    let completedButton = UIButton()
    let importantButton = UIButton()
    
    var isDeletePressed = false
    var todoItem: ToDoModel!
    weak var delegate:DetailsVCDelegate?
    

    // MARK: - Methods
    override func viewDidLoad() {
        prepareView()
        prepareData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // call delegate when user wants to get back or delete the task
        if isDeletePressed {
            delegate?.delete(item: todoItem)
        } else {
            delegate?.saveChanges(item: todoItem)
        }
    }
    
    
    private func prepareView() {
        // Prepare Ui properties Constraints and positions

        
        // prepare ListTable
        view.addSubview(backgroundView)
        backgroundView.prepareLayout(.top)
        backgroundView.prepareLayout(.bottom)
        backgroundView.prepareLayout(.leading)
        backgroundView.prepareLayout(.trailing)
        backgroundView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        // prepare ListTable
        backgroundView.addSubview(deletebutton)
        deletebutton.prepareLayout(.bottom,constant: -20)
        deletebutton.prepareLayout(.leading,constant: 10)
        deletebutton.prepareLayout(.trailing,constant: -10)
        deletebutton.prepareHeight(constant: 60)
        deletebutton.backgroundColor = .black
        deletebutton.cornerRadius(color: .lightGray)
        deletebutton.setTitle(.deleteTask)
        deletebutton.addTarget(self, action: #selector(deletePressed),
                                for: .touchUpInside)
        
        
        // prepare ListTable
        backgroundView.addSubview(titleText)
        titleText.prepareLayout(.top,constant: topbarHeight() + 10)
        titleText.prepareLayout(.leading,constant: 10)
        titleText.prepareLayout(.trailing,constant: -10)
        titleText.prepareHeight(constant: 40)
        titleText.cornerRadius(color: .black)
        titleText.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)

        backgroundView.addSubview(importantButton)
        importantButton.prepareLayout(.trailing, constant: -15)
        importantButton.prepareLayout(.top,toItem: titleText,constant: 20)
        importantButton.prepareHeight(constant: 30)
        importantButton.prepareWidth(constant: 30)
        importantButton.addTarget(self, action: #selector(importantPressed),
                                for: .touchUpInside)
        
        backgroundView.addSubview(completedButton)
        completedButton.prepareLayout(.trailing, constant: -15)
        completedButton.prepareLayout(.top,toItem: importantButton,constant: 20)
        completedButton.prepareHeight(constant: 30)
        completedButton.prepareWidth(constant: 30)
        completedButton.addTarget(self, action: #selector(completePressed),
                                for: .touchUpInside)
        
        backgroundView.addSubview(sheduleButton)
        sheduleButton.prepareLayout(.trailing, constant: -15)
        sheduleButton.prepareLayout(.top,toItem: completedButton,constant: 20)
        sheduleButton.prepareHeight(constant: 35)
        sheduleButton.prepareWidth(constant: 35)
        sheduleButton.addTarget(self, action: #selector(sheduleIconPressed),
                                for: .touchUpInside)

        // prepare Title label
        backgroundView.addSubview(createdLabel)
        createdLabel.prepareLayout(.leading,constant: 15)
        createdLabel.prepareLayout(.top,toItem: titleText,constant: 30)
        createdLabel.prepareTextField(size: .title)
        
        // prepare Title label
        backgroundView.addSubview(lastEditedLabel)
        lastEditedLabel.prepareLayout(.top,toItem: createdLabel,constant: 30)
        lastEditedLabel.prepareLayout(.leading,constant: 15)
        lastEditedLabel.prepareTextField(size: .title)
                
        // Date
        backgroundView.addSubview(datePicker)
        datePicker.locale = .current
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        datePicker.prepareLayout(.leading,constant: 10)
        datePicker.prepareLayout(.top,toItem: lastEditedLabel,constant: 30)
    }

    
    func prepareData() {
        // prepare Data of Details Screen and Ui Properties

        guard let data = todoItem else { return }
        
        // show title screen when task name less than 5 character
        title = data.title.count > 5 ? "\(String(data.title.prefix(5)))..." : String(data.title.prefix(5))
        datePicker.date = data.sheduleTime
        titleText.text = data.title
        
        completedButton.changeState(button: .Complete,isEnable: !data.isDone)
        importantButton.changeState(button: .Important,isEnable: !data.isImportant)
        sheduleButton.changeState(button: .Shedule,isEnable: !data.isSheduled)

        createdLabel.text =    "Creadted     " + data.createdTime.time()
        lastEditedLabel.text = "Last Edited  " + data.lastEditedTime.time()
    }
    
    
    @objc func textFieldDidChange(textField: UITextField){
        // change task name when editing textUI
        guard let text = titleText.text,!text.isEmpty else { return }
        todoItem.title = text
    }
    
    @objc func importantPressed(){
        // change Task state Prioritize and text UI
        todoItem.isImportant = !todoItem.isImportant
        importantButton.changeState(button: .Important,
                                    isEnable: !todoItem.isImportant)
    }
    
    @objc func deletePressed(){
        // assign closing state when user delete the task and get back to previous screen
        isDeletePressed = true
        navigationController?.popViewController(animated: true)
    }
    
    @objc func completePressed(){
        // change Task state complete and text UI
        todoItem.isDone = !todoItem.isDone
        completedButton.changeState(button: .Complete,
                                    isEnable: !todoItem.isDone)
        titleText.isEnabled = !todoItem.isDone
        titleText.strikeThrough(enable: todoItem.isDone)

    }
    
    @objc func timeChanged(_ sender: UIDatePicker) {
        // Get the selcted time from date picker when user changing date and time
        todoItem.sheduleTime = sender.date
        todoItem.isSheduled = true
        sheduleButton.changeState(button: .Shedule,
                                    isEnable: false)
    }
    
    
    // MARK: - When user Enable and disable Shedule Task
    @objc func sheduleIconPressed(){
        
        if !todoItem.isSheduled {
            // assign Shedule time as one hour extra from current
            todoItem.sheduleTime = Calendar.current.date(byAdding: .hour,
                                                         value: 1,
                                                         to: Date())!
            datePicker.setDate(todoItem.sheduleTime, animated: true)

        } else {
            // assign Shedule time as created time when State Off
            todoItem.sheduleTime = todoItem.createdTime
        }

        // changing task shedule State On/Off
        sheduleButton.changeState(button: .Shedule, isEnable: todoItem.isSheduled)
        todoItem.isSheduled = !todoItem.isSheduled
    }
    
    
    // MARK: - To get the height of Navigation bar to assign title top spacing
    func topbarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height + navigationController!.navigationBar.frame.height
    }
}
