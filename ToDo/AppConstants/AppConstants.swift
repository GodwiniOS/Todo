//
//  AppConstants.swift
//  ToDo
//
//  Created by Godwin  on 02/01/21.
//

import UIKit

enum FontSize: CGFloat {
    
    case title = 16
    case subtite = 10
}


enum Categories: String {

    case DateCreated    = "Created"
    case DateEdited = "Last Edited"
    case Priority   = "Important"
    case Completed  = "Completed"
    case Shedule    = "Shedule"
    case Normal = "Cancel"
}

enum AppTitle: String {

    case listVCTitle    = "To Do List"
    case addNew = "Add New"
    case deleteTask = "Delete task"
}

enum AppButton {
    
    case Complete
    case Important
    case Shedule
    
    
    func imageName(enable: Bool = false) -> String {
        switch self {
        case .Complete:
            return enable ? "Complete" : "Completed"
        case .Important:
            return enable ? "Importatant" : "Importance"
        case .Shedule:
            return enable ? "SheduleOff" : "SheduleOn"
        }
    }
}
