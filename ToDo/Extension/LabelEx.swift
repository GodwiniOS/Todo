//
//  LabelEx.swift
//  ToDo
//
//  Created by Godwin  on 30/12/20.
//
import UIKit


extension UILabel{

    func prepareTextField(size: FontSize) {
        font = font.withSize(size.rawValue)
        textColor = .black
    }
    
    func strikeThrough() {
        let attrString = NSAttributedString(string: text ?? "", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        attributedText = attrString
        textColor = .gray
    }
}


extension UITextField{
    
    func strikeThrough(enable: Bool) {
        
        if enable {
            let attrString = NSAttributedString(string: text ?? "", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            attributedText = attrString
            textColor = .gray
        } else {
            attributedText = NSAttributedString(string: text ?? "")
            textColor = .black
        }
    }
}
