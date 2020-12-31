//
//  LabelEx.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//
import UIKit


enum FontSize: CGFloat {
    
    case title = 32
    case subtite = 16
}

enum FontName: String {
    
    case Light      = "HelveticaNeue-Light"
    case Regular    = "HelveticaNeue-Regular"
    case Medium     = "HelveticaNeue-SemiBold"
    case Bold       = "HelveticaNeue-Bold"
}


enum AppImage: String {
    
    case importance = "Importance"
    case importatant    = "Importatant"
    case completed      = "Completed"
    case complete       = "Complete"
}


extension UILabel{

    func prepareTextField() {
        font = UIFont(name: FontName.Regular.rawValue,
                           size: FontSize.title.rawValue)
        textColor = .black
    }
}
