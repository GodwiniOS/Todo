//
//  ItemDetailsVC.swift
//  ToDo
//
//  Created by Godwin  on 31/12/20.
//

import UIKit

class ItemDetailsVC: UIViewController {

    
    var backgroundView = UIView()
    var sheduleButton = UIButton()
    
    override func viewDidLayoutSubviews() {
        prepareView()
    }
    
    
    private func prepareView() {
        
        // prepare ListTable
        view.addSubview(backgroundView)
        backgroundView.prepareLayout(.top)
        backgroundView.prepareLayout(.bottom)
        backgroundView.prepareLayout(.leading)
        backgroundView.prepareLayout(.trailing)
        backgroundView.backgroundColor = .white
        
        // prepare ListTable
        view.addSubview(sheduleButton)
        sheduleButton.prepareLayout(.bottom,constant: -10)
        sheduleButton.prepareLayout(.leading,constant: 10)
        sheduleButton.prepareLayout(.trailing,constant: -10)
        sheduleButton.prepareHeight(constant: 60)
        sheduleButton.backgroundColor = .black
        sheduleButton.cornerRadius(constant: 10, color: .lightGray)
        sheduleButton.setTitle("Shedule", for: .normal)
        sheduleButton.addTarget(self, action: #selector(pressed),
                                for: .touchUpInside)
    }
    
    @objc func pressed(){
        
    }
}
