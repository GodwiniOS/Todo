//
//  ViewControllerEx.swift
//  ToDo
//
//  Created by Godwin  on 30/12/20.
//

import UIKit


extension UIViewController {
    
    func prepareBarButton()  {
        title = "List"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]

        let barButton = UIBarButtonItem(title: AppTitle.listVCTitle.rawValue,
                                        style: .plain,
                                        target: self,
                                        action: nil)
        navigationItem.leftBarButtonItem = barButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .black
        barButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20)!],
                                         for: .normal)
        
    }
}
