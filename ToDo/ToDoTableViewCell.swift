//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    let backGroundView = UIView()
//    let titleLabel = UILabel()
//    let subTitlelabel = UILabel()
//    let completedButton = UIButton()
//    let importantButton = UIButton()

    func prepareTableViewCell() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.superview?.backgroundColor = .clear
        
        contentView.addSubview(backGroundView)
        backGroundView.prepareLayout(attribute: .leading)
        backGroundView.prepareLayout(attribute: .trailing)
        backGroundView.prepareHeight(constant: 120)
        backGroundView.backgroundColor = .darkGray
        
        
//        backGroundView.addSubview(titleLabel)
//        backGroundView.addSubview(subTitlelabel)
//        backGroundView.addSubview(completedButton)
//        backGroundView.addSubview(importantButton)
    }
}
