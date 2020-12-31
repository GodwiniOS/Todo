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
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
//    let txtDatePicker = UITextField()

    override func viewDidLoad() {
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
        
        
        datePicker.date = Date()
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        view.addSubview(datePicker)
        datePicker.prepareLayout(.leading,constant: 10)
        datePicker.prepareLayout(.trailing,constant: -10)
        datePicker.prepareLayout(.top,constant: 80)
        
        
        timePicker.date = Date()
        timePicker.locale = .current
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        view.addSubview(timePicker)
        timePicker.prepareLayout(.leading,constant: 10)
        timePicker.prepareLayout(.trailing,constant: -10)
        timePicker.prepareLayout(.top,constant: 120)

    }
    
    @objc func pressed(){
        
    }
    
    @objc func timeChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)")
        }
    }

    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)")
        }
    }
}

