//
//  ViewEx.swift
//  ToDo
//
//  Created by Godwin  on 30/12/20.
//

import UIKit

extension UIView {
    
    func prepareLayout(_ attribute: NSLayoutConstraint.Attribute,
                       toItem :UIView? = nil,
                       constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        let withItem: UIView! =  toItem != nil ? toItem! : superview
        let withAttribute: NSLayoutConstraint.Attribute! = toItem != nil ? .bottom : attribute

        let layout = NSLayoutConstraint(item: self,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: withItem,
                                        attribute: withAttribute,
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
    
    
    func cornerRadius(constant: CGFloat = 10,color: UIColor,
                      width: CGFloat = 1){
        layer.cornerRadius = constant;
        layer.masksToBounds = true;
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
