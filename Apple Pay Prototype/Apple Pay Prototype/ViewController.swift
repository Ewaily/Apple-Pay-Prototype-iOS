//
//  ViewController.swift
//  Apple Pay Prototype
//
//  Created by Muhammad Ewaily on 18/05/2022.
//

import UIKit

class ViewController: UIViewController {
    
    // Data Setup
    
    struct iPhone {
        var name: String
        var price: Double
    }
    
    let iPhoneData = [
        iPhone(name: "iPhone 13 Pro Max", price: 1399),
        iPhone(name: "iPhone 12 Pro Max", price: 1200),
        iPhone(name: "iPhone 11 Pro Max", price: 1100),
        iPhone(name: "iPhone XS Max", price: 900),
    ]
    
    // Storyboard outlets
    
    @IBOutlet weak var iPhonePickerView: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBAction func buyiPhoneTapped(_ sender: UIButton) {
        
        // Open Apple Pay purchase
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iPhonePickerView.delegate = self
        iPhonePickerView.dataSource = self
        
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Pickerview update
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iPhoneData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return iPhoneData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let priceString = String(format: "%.02f", iPhoneData[row].price)
        priceLabel.text = "Price = $\(priceString)"
    }
}
