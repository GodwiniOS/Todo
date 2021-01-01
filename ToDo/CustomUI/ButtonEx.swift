//
//  ButtonEx.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit

extension UIButton {

    func setImage(name: AppImage){
        setImage(UIImage(named: name.rawValue),for: .normal)
    }
    
    func changeState(button: AppButton,isEnable: Bool){
        switch button {
        case .complete:
            setImage(name: isEnable ? .complete : .completed)
        case .important:
            setImage(name: isEnable ? .importatant: .importance)
        case .shedule:
            setImage(name: isEnable ? .sheduleOff : .sheduleOn)
        }
    }
}
