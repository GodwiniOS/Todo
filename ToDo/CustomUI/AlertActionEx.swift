//
//  AlertActionEx.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit



extension UIAlertAction {

    func prepare(){
        setValue(UIColor.black, forKey: "titleTextColor")
    }
}


extension Date {

    func time() -> String {

        let hour = Calendar.current.component(.hour, from: self)
        let minutes = Calendar.current.component(.minute, from: self)
        let day = Calendar.current.component(.day, from: self)
        let month = Calendar.current.component(.month, from: self)
        let year = Calendar.current.component(.year, from: self)
        
        return "\(hour):\(minutes)    \(day)-\(month)-\(year)"
    }
}
