//
//  LabelEx.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//
import UIKit


enum FontSize: CGFloat {
    
    case title = 16
    case subtite = 10
}

enum FontName: String {
    
    case Light      = "HelveticaNeue-Light"
    case Regular    = "HelveticaNeue-Regular"
    case Medium     = "HelveticaNeue-SemiBold"
    case Bold       = "HelveticaNeue-Bold"
}


enum AppImage: String {
    
    case importance = "Importance"
    case sheduleOff = "SheduleOff"
    case sheduleOn  = "SheduleOn"
    case importatant    = "Importatant"
    case completed      = "Completed"
    case complete       = "Complete"
}

enum AppButton: String {
    
    case complete
    case important
    case shedule
}

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
