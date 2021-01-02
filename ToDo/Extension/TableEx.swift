//
//  TableEx.swift
//  ToDo
//
//  Created by Godwin  on 02/01/21.
//

import UIKit

extension UITableView {

    func registerCell() {
        self.register(ToDoTableViewCell.self, forCellReuseIdentifier: "DefaultCell")
    }
}
