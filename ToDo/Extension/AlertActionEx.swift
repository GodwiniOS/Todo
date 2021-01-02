//
//  AlertActionEx.swift
//  ToDo
//
//  Created by Godwin  on 30/12/20.
//

import UIKit

extension UIAlertAction {

    func prepare(color: UIColor = .black){
        setValue(color, forKey: "titleTextColor")
    }
}


extension Date {

    func time() -> String {

        var hour = Calendar.current.component(.hour, from: self)
        let minutes = Calendar.current.component(.minute, from: self)
        let day = Calendar.current.component(.day, from: self)
        let month = Calendar.current.component(.month, from: self)
        let year = Calendar.current.component(.year, from: self)
        
        var Median = "AM"
        if hour > 12 {
            hour -= 12
            Median = "PM"
        }
        return "\(hour):\(minutes) \(Median) \(day)-\(month)-\(year)"
    }
}
