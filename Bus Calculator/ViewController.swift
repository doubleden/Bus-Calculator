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
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action:#selector(self.hideKeyboard)
        )
        toolbar.setItems([doneButton], animated: false)
        
        startSumTextField.keyboardType = .numberPad
        startSumTextField.inputAccessoryView = toolbar
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        calculateButtonDidTapped()
    }
    
    private func calculateButtonDidTapped() {
        if let startSum = Double(startSumTextField.text ?? "0") {
            let sumAfterTax = Int(startSum - (startSum * tax))
            taxLabel.text = String(sumAfterTax)
            planLabel.text = String(sumAfterTax - 100000)
        }
    }
}

