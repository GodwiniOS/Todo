//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit


protocol ToDoTVCDelegate: AnyObject {
    func completeButtonClicked(index: Int)
    func importantButtonClicked(index: Int)
}



class ToDoTableViewCell: UITableViewCell {

    let backGroundView = UIView()
    let titleLabel = UILabel()
    let subTitlelabel = UILabel()
    let completedButton = UIButton()
    let importantButton = UIButton()
    let sheduleIcon = UIImageView()
    
    var index : Int!
    weak var delegate : ToDoTVCDelegate?
    
    func prepareTableViewCell() {
        
        // prepare Background
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.superview?.backgroundColor = .clear
        contentView.prepareHeight(constant: 60)
        contentView.addSubview(backGroundView)
        
        backGroundView.prepareLayout(.leading,constant: 10)
        backGroundView.prepareLayout(.trailing,constant: -10)
        backGroundView.prepareLayout(.top,constant: 10)
        backGroundView.prepareLayout(.bottom)
        backGroundView.cornerRadius(color: .lightGray)

        // prepare completedButton
        backGroundView.addSubview(completedButton)
        completedButton.prepareLayout(.leading,constant: 15)
        completedButton.prepareLayout(.top,constant: 10)
        completedButton.prepareHeight(constant: 30)
        completedButton.prepareWidth(constant: 30)
        completedButton.setImage(name: .Complete)
        completedButton.addTarget(self, action: #selector(completeTapped),
                                for: .touchUpInside)
        
        // prepare importantButton
        backGroundView.addSubview(importantButton)
        importantButton.prepareLayout(.trailing, constant: -15)
        importantButton.prepareLayout(.top,constant: 10)
        importantButton.prepareHeight(constant: 30)
        importantButton.prepareWidth(constant: 30)
        importantButton.setImage(name: .Important)
        importantButton.addTarget(self,
                                  action: #selector(importantTapped),
                                for: .touchUpInside)
        
        // prepare Title label
        backGroundView.addSubview(titleLabel)
        titleLabel.prepareLayout(.leading,constant: 60)
        titleLabel.prepareLayout(.top,constant: 8)
        titleLabel.prepareLayout(.trailing,constant: -60)
        titleLabel.prepareTextField(size: .title)
        
        // prepare Title label
        backGroundView.addSubview(sheduleIcon)
        sheduleIcon.prepareLayout(.leading,constant: 60)
        sheduleIcon.prepareLayout(.bottom,constant: -8)
        sheduleIcon.prepareHeight(constant: 10)
        sheduleIcon.prepareWidth(constant: 10)
        sheduleIcon.image = UIImage(named: AppButton.Shedule.imageName())
        
        // prepare Title label
        backGroundView.addSubview(subTitlelabel)
        subTitlelabel.prepareLayout(.leading,constant: 80)
        subTitlelabel.prepareLayout(.bottom,constant: -8)
        subTitlelabel.prepareLayout(.trailing,constant: -60)
        subTitlelabel.prepareTextField(size: .subtite)
    }
    
    func prepareData(todoItem: ToDoModel,index: Int){
        self.index = index
        titleLabel.text = todoItem.title
        if todoItem.isDone { titleLabel.strikeThrough() }
        subTitlelabel.text = todoItem.sheduleTime.time()
        subTitlelabel.isHidden = !todoItem.isSheduled
        sheduleIcon.isHidden = !todoItem.isSheduled
        completedButton.changeState(button: .Complete, isEnable: !todoItem.isDone)
        importantButton.changeState(button: .Important,isEnable: !todoItem.isImportant)
    }
    
    @objc func completeTapped() {
        delegate?.completeButtonClicked(index: index)
    }
        
    @objc func importantTapped() {
        delegate?.importantButtonClicked(index: index)
    }
}
