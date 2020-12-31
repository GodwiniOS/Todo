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


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        prepareView()
    }
    
    
    
    private func prepareView() {
        
        view.addSubview(backgroundView)
        
        // prepare ListTable
        backgroundView.prepareLayout(attribute: .top)
        backgroundView.prepareLayout(attribute: .bottom)
        backgroundView.prepareLayout(attribute: .leading)
        backgroundView.prepareLayout(attribute: .trailing)
        backgroundView.backgroundColor = .white
        
        view.addSubview(sheduleButton)
        
        // prepare ListTable
        sheduleButton.prepareLayout(attribute: .bottom,
                                    constant: -10)
        sheduleButton.prepareLayout(attribute: .leading,
                                    constant: 10)
        sheduleButton.prepareLayout(attribute: .trailing,
                                    constant: -10)
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
