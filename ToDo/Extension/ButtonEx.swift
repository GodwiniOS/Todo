//
//  ButtonEx.swift
//  ToDo
//
//  Created by Godwin  on 30/12/20.
//

import UIKit

extension UIButton {

    func setImage(name: AppButton){
        setImage(UIImage(named: name.imageName()),for: .normal)
    }
    
    func changeState(button: AppButton,isEnable: Bool){
        setImage(UIImage(named: button.imageName(enable: isEnable)),
                 for: .normal)

    }
    
    func setTitle(_ title: AppTitle) {
        setTitle(title.rawValue, for: .normal)
    }
}
