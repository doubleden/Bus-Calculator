//
//  ViewController.swift
//  Bus Calculator
//
//  Created by Denis Denisov on 31/1/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var startSumTextField: UITextField!
    @IBOutlet var taxLabel: UILabel!
    @IBOutlet var planLabel: UILabel!
    
    private let tax = 12.7 / 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taxLabel.clipsToBounds = true
        taxLabel.layer.cornerRadius = 10
        planLabel.clipsToBounds = true
        planLabel.layer.cornerRadius = 10
        setupKeyboard()
    }
    
    @objc func calculate() {
        if let startSum = Double(startSumTextField.text ?? "0") {
            let sumAfterTax = Int(startSum - (startSum * tax))
            taxLabel.text = sumAfterTax.formatted()
            planLabel.text = (sumAfterTax - 100000).formatted()
        }
    }
    
    @objc func clenaStartSumTextField() {
        startSumTextField.text = ""
    }
    
    private func setupKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let calcButton = UIBarButtonItem(
            title: "Посчитать",
            style: .plain,
            target: self,
            action:#selector(self.calculate)
        )
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let cleanButton = UIBarButtonItem(
            title: "Стереть",
            style: .plain,
            target: self,
            action: #selector(self.clenaStartSumTextField)
        )
        
        toolbar.setItems([cleanButton, flexibleSpace, calcButton], animated: false)
        startSumTextField.inputAccessoryView = toolbar
        startSumTextField.becomeFirstResponder()
    }
}

