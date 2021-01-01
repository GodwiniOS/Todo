//
//  ItemDetailsVC.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit

protocol DetailsVCDelegate: AnyObject {
    func saveChanges(item: ToDoModel)
    func delete(item: ToDoModel)
}


class ItemDetailsVC: UIViewController{

    
    let backgroundView = UIView()
    let datePicker = UIDatePicker()

    let createdLabel = UILabel()
    let sheduleLabel = UILabel()
    let lastEditedLabel = UILabel()

    var titleText = UITextField()
    
    let completedButton = UIButton()
    let importantButton = UIButton()
    let sheduleButton = UIButton()
    
    let deletebutton = UIButton()
    var isDeletePressed = false
    var todoItem: ToDoModel!
    weak var delegate:DetailsVCDelegate?
    override func viewDidLoad() {
        prepareView()
        prepareData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if isDeletePressed {
            delegate?.delete(item: todoItem)
        } else {
            delegate?.saveChanges(item: todoItem)
        }
    }
    
    
    
    private func prepareView() {
        
        // prepare ListTable
        view.addSubview(backgroundView)
        backgroundView.prepareLayout(.top)
        backgroundView.prepareLayout(.bottom)
        backgroundView.prepareLayout(.leading)
        backgroundView.prepareLayout(.trailing)
        backgroundView.backgroundColor = .white
        
        // prepare ListTable
        view.addSubview(deletebutton)
        deletebutton.prepareLayout(.bottom,constant: -10)
        deletebutton.prepareLayout(.leading,constant: 10)
        deletebutton.prepareLayout(.trailing,constant: -10)
        deletebutton.prepareHeight(constant: 60)
        deletebutton.backgroundColor = .black
        deletebutton.cornerRadius(color: .lightGray)
        deletebutton.setTitle("Delete task", for: .normal)
        deletebutton.addTarget(self, action: #selector(deletePressed),
                                for: .touchUpInside)
        
        
        // prepare ListTable
        view.addSubview(titleText)
        titleText.prepareLayout(.top,constant: 80)
        titleText.prepareLayout(.leading,constant: 10)
        titleText.prepareLayout(.trailing,constant: -10)
        titleText.prepareHeight(constant: 40)
        titleText.cornerRadius(color: .black)
        titleText.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)

        view.addSubview(importantButton)
        importantButton.prepareLayout(.trailing, constant: -15)
        importantButton.prepareLayout(.top,constant: 140)
        importantButton.prepareHeight(constant: 30)
        importantButton.prepareWidth(constant: 30)
        importantButton.addTarget(self, action: #selector(importantPressed),
                                for: .touchUpInside)
        
        view.addSubview(completedButton)
        completedButton.prepareLayout(.trailing, constant: -15)
        completedButton.prepareLayout(.top,constant: 190)
        completedButton.prepareHeight(constant: 30)
        completedButton.prepareWidth(constant: 30)
        completedButton.addTarget(self, action: #selector(completePressed),
                                for: .touchUpInside)
        
        
        view.addSubview(sheduleButton)
        sheduleButton.prepareLayout(.trailing, constant: -15)
        sheduleButton.prepareLayout(.top,constant: 240)
        sheduleButton.prepareHeight(constant: 35)
        sheduleButton.prepareWidth(constant: 35)
        sheduleButton.addTarget(self, action: #selector(sheduleIconPressed),
                                for: .touchUpInside)

        
        // prepare Title label
        view.addSubview(createdLabel)
        createdLabel.prepareLayout(.leading,constant: 15)
        createdLabel.prepareLayout(.top,constant: 150)
        createdLabel.prepareTextField(size: .title)
        createdLabel.text = "sfdsfsfs"

        
        // prepare Title label
        view.addSubview(lastEditedLabel)
        lastEditedLabel.prepareLayout(.top,constant: 200)
        lastEditedLabel.prepareLayout(.leading,constant: 15)
        lastEditedLabel.prepareTextField(size: .title)
        lastEditedLabel.text = "sfdsfsfs"
        
        
        // Date
        datePicker.locale = .current
        datePicker.datePickerMode = .dateAndTime

        datePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)

        view.addSubview(datePicker)
        datePicker.prepareLayout(.leading,constant: 10)
        datePicker.prepareLayout(.top,constant: 250)
    }

    
    @objc func timeChanged(_ sender: UIDatePicker) {
        todoItem.sheduleTime = sender.date
        todoItem.isSheduled = true
        sheduleButton.changeState(button: .shedule,
                                    isEnable: false)
//        let components = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
//        if let minute = components.minute, let hour = components.hour {
//            print("\(minute) \(hour)")
//        }
    }
    
    
    @objc func importantPressed(){
        todoItem.isImportant = !todoItem.isImportant
        importantButton.changeState(button: .important,
                                    isEnable: !todoItem.isImportant)
    }
    
    @objc func completePressed(){
        todoItem.isDone = !todoItem.isDone
        completedButton.changeState(button: .complete,
                                    isEnable: !todoItem.isDone)
        titleText.isEnabled = !todoItem.isDone
        titleText.strikeThrough(enable: todoItem.isDone)

    }

    @objc func sheduleIconPressed(){
        
        if !todoItem.isSheduled {
            todoItem.sheduleTime = Calendar.current.date(byAdding: .hour,
                                                         value: 1,
                                                         to: Date())!
            datePicker.setDate(todoItem.sheduleTime, animated: true)
            todoItem.isSheduled = true
            sheduleButton.changeState(button: .shedule, isEnable: false)

        } else {
            todoItem.isSheduled = false
            sheduleButton.changeState(button: .shedule, isEnable: true)
        }
    }
    
    @objc func deletePressed(){
        isDeletePressed = true
        navigationController?.popViewController(animated: true)
    }
    
    
    func prepareData() {
        
        guard let data = todoItem else { return }
        
        
        datePicker.date = data.sheduleTime
        titleText.text = data.title
        completedButton.setImage(name: !data.isDone ? .complete : .completed)
        importantButton.setImage(name: !data.isImportant ? .importatant : .importance)
        sheduleButton.setImage(name: data.isSheduled ? .sheduleOn : .sheduleOff)
        
        createdLabel.text = "Creadted " + data.createdTime.time()
        lastEditedLabel.text = "Last Edited " + data.lastEditedTime.time()
    }
    
    
    @objc func textFieldDidChange(textField: UITextField){

        guard let text = titleText.text,!text.isEmpty else { return }
        todoItem.title = text
    }
}

