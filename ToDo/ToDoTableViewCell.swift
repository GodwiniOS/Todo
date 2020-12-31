//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit


protocol ToDoTVCDelegate {
    func completeButtonClicked(index: Int)
    func importantButtonClicked(index: Int)
}



class ToDoTableViewCell: UITableViewCell {

    let backGroundView = UIView()
    let titleLabel = UILabel()
    let subTitlelabel = UILabel()
    let completedButton = UIButton()
    let importantButton = UIButton()
    var index : Int!
    
    var delegate : ToDoTVCDelegate?

    
    func prepareTableViewCell() {
        
        
        // prepare Background
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.superview?.backgroundColor = .clear
        contentView.prepareHeight(constant: 60)
        contentView.addSubview(backGroundView)
        backGroundView.prepareLayout(attribute: .leading,
                                     constant: 10)
        backGroundView.prepareLayout(attribute: .trailing,
                                     constant: -10)
        backGroundView.prepareLayout(attribute: .top,
                                     constant: 5)
        backGroundView.prepareLayout(attribute: .bottom,
                                     constant: -5)

        
        backGroundView.cornerRadius(constant: 10, color: .lightGray)

        
        // prepare completedButton
        backGroundView.addSubview(completedButton)
        completedButton.prepareLayout(attribute: .leading,
                                     constant: 15)
        completedButton.prepareLayout(attribute: .top,
                                     constant: 10)
        completedButton.prepareHeight(constant: 30)
        completedButton.prepareWidth(constant: 30)
        completedButton.setImage(name: .complete)
        completedButton.addTarget(self, action: #selector(completeTapped),
                                for: .touchUpInside)
        
        

        
        // prepare importantButton
        backGroundView.addSubview(importantButton)
        importantButton.prepareLayout(attribute: .trailing,
                                     constant: -15)
        importantButton.prepareLayout(attribute: .top,
                                     constant: 10)
        importantButton.prepareHeight(constant: 30)
        importantButton.prepareWidth(constant: 30)
        importantButton.setImage(name: .importatant)
        importantButton.addTarget(self, action: #selector(importantTapped),
                                for: .touchUpInside)
        
        
        // prepare Title label
        backGroundView.addSubview(titleLabel)
        titleLabel.prepareLayout(attribute: .leading,
                                     constant: 60)
        titleLabel.prepareLayout(attribute: .top,
                                     constant: 10)
        
        titleLabel.prepareLayout(attribute: .trailing,
                                 constant: -60)
        titleLabel.prepareTextField()
    }
    
    func prepareData(todoItem: ToDoModel,index: Int){
        self.index = index
        titleLabel.text = todoItem.title
        if todoItem.isDone { titleLabel.strikeThrough() }
        completedButton.setImage(name: todoItem.isDone ? .completed : .complete)
        importantButton.setImage(name: todoItem.isImportant ? .importance : .importatant)

    }
    
    @objc func completeTapped() {
        delegate?.completeButtonClicked(index: index)
    }
        
    @objc func importantTapped() {
        delegate?.importantButtonClicked(index: index)
    }
}
