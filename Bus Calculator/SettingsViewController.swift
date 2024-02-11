//
//  SettingsViewController.swift
//  Bus Calculator
//
//  Created by Denis Denisov on 10/2/24.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet var currentTaxValueLabel: UILabel!
    @IBOutlet var currentPlanValueLabel: UILabel!
    
    @IBOutlet var taxTextField: UITextField!
    @IBOutlet var planTextField: UITextField!
    
    var currentTax: String!
    var currentPlan: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTaxValueLabel.text = "Текущий процент: \(currentTax ?? "")"
        currentPlanValueLabel.text = "Текущий план: \(currentPlan ?? "")"
        
        taxTextField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged
        )
        
        taxTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
