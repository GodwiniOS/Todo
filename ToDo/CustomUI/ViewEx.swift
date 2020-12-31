//
//  ViewEx.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit

extension UIView {
    
    func prepareLayout(_ attribute: NSLayoutConstraint.Attribute,constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        let layout = NSLayoutConstraint(item: self,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: superview,
                                        attribute: attribute,
                                        multiplier: 1,
                                        constant: constant)
        NSLayoutConstraint.activate([layout])
    }
    
    
    func prepareHeight(constant: CGFloat) {
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant)
        NSLayoutConstraint.activate([constraint])
    }
    
    func prepareWidth(constant: CGFloat) {
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant)
        NSLayoutConstraint.activate([constraint])
    }
    
    
    func cornerRadius(constant: CGFloat,color: UIColor,
                      width: CGFloat = 1){
        layer.cornerRadius = constant;
        layer.masksToBounds = true;
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
