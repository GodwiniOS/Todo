//
//  TextField.swift
//  ToDo
//
//  Created by Godwin  on 30/12/20.
//

import UIKit

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

     override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
     }

     override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
     }

     override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
     }
}
