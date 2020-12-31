//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    let backGroundView = UIView()
    let titleLabel = UILabel()
    let subTitlelabel = UILabel()
    let completedButton = UIButton()
    let importantButton = UIButton()

    func prepareTableViewCell() {
        
        
        // prepare Background
        backgroundColor = .clear
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
        
        
//        addButton.setImage(UIImage(with: .ADDICON), for: UIControl.State.normal)

        
        
        
        if #available(iOS 13.0, *) {
            let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
            let boldSearch = UIImage(systemName: "search", withConfiguration: boldConfig)

            importantButton.setImage(boldSearch, for: .normal)
        } else {
        }

        
        
        

        
        // prepare importantButton
        backGroundView.addSubview(importantButton)
        importantButton.prepareLayout(attribute: .trailing,
                                     constant: -15)
        importantButton.prepareLayout(attribute: .top,
                                     constant: 10)
        importantButton.prepareHeight(constant: 30)
        importantButton.prepareWidth(constant: 30)
        importantButton.backgroundColor = .lightGray
//        importantButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)

        
        
        // prepare Title label
        backGroundView.addSubview(titleLabel)
        titleLabel.prepareLayout(attribute: .leading,
                                     constant: 60)
        titleLabel.prepareLayout(attribute: .top,
                                     constant: 10)
        titleLabel.prepareTextField()
        titleLabel.text = "fnjknkf"
        
//        backGroundView.addSubview(subTitlelabel)
//        backGroundView.addSubview(completedButton)
//        backGroundView.addSubview(importantButton)
    }
}
