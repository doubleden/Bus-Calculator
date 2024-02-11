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
    
    @IBAction func saveButtonTapped() {
        
        guard var newTaxInput = taxTextField.text else { return }
        guard var newPlanInput = planTextField.text else { return }
        
        if newTaxInput.isEmpty && newPlanInput.isEmpty {
            showAlert(
                withTitle: "Ops..",
                andMessage: "Чтобы, сохранить вы должны внести изминения хотяб в одном поле!"
            )
        } else {
            newTaxInput = newTaxInput.isEmpty ? currentTax : newTaxInput
            newPlanInput = newPlanInput.isEmpty ? currentPlan : newPlanInput
            
            if isValid(text: newTaxInput) && isValid(text: newPlanInput) {
                performSegue(withIdentifier: "returnToMain", sender: self)
            } else {
                showAlert(withTitle: "Упс..", andMessage: "Вы ввели не корректные данные")
            }
        }
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
