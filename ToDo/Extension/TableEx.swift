//
//  TableEx.swift
//  ToDo
//
//  Created by Godwin  on 30/12/20.
//

import UIKit

extension UITableView {

    func registerCell() {
        self.register(ToDoTableViewCell.self, forCellReuseIdentifier: "DefaultCell")
    }
}
