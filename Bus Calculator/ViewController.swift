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
    @IBOutlet var calculateButtonLabel: UIButton!
    
    private let tax = 12.7 / 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSumTextField.keyboardType = .numberPad
        calculateButtonLabel.layer.cornerRadius = 15
        
        taxLabel.clipsToBounds = true
        taxLabel.layer.cornerRadius = 10
        planLabel.clipsToBounds = true
        planLabel.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func calculateButtonDidTapped() {
        if let startSum = Double(startSumTextField.text ?? "0") {
            let sumAfterTax = Int(startSum - (startSum * tax))
            taxLabel.text = String(sumAfterTax)
            planLabel.text = String(sumAfterTax - 100000)
        }
    }
}

