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
}
