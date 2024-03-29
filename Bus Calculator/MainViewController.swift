//
//  ViewController.swift
//  Bus Calculator
//
//  Created by Denis Denisov on 31/1/24.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet var inputSumTF: UITextField!
    
    @IBOutlet var taxValueLabel: UILabel!
    @IBOutlet var planValueLabel: UILabel!
    
    @IBOutlet var taxFrameLabel: UILabel!
    @IBOutlet var planFrameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taxFrameLabel.clipsToBounds = true
        taxFrameLabel.layer.cornerRadius = 10
        planFrameLabel.clipsToBounds = true
        planFrameLabel.layer.cornerRadius = 10
        
        inputSumTF.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged
        )
        inputSumTF.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.currentTax = taxValueLabel.text
            settingsVC.currentPlan = planValueLabel.text
        }
    }

    @IBAction func countButtonTapped() {
        guard let inputText = inputSumTF.text, !inputText.isEmpty else {
            showAlert(
                withTitle: "Ошибка",
                andMessage: "Поле ввода не может быть пустым"
            )
            return
        }
        
        guard isValid(text: inputText) else { return }
        
        guard let inputNumber = Double(inputSumTF.text ?? ""),
                inputNumber > 0.0 else {
            showAlert(
                withTitle: "Сумма введена некорректно",
                andMessage: "Введите сумму больше 0"
            )
            return
        }
            
        guard let tax = Double(taxValueLabel.text ?? "") else { return }
        guard let plan = Int(planValueLabel.text ?? "") else { return }
            
        let taxDecimal = tax / 100
        let sumAfterTax = Int(inputNumber - (inputNumber * taxDecimal))
            
        taxFrameLabel.text = sumAfterTax.formatted()
        planFrameLabel.text = (sumAfterTax - plan).formatted()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        if let settingVC = segue.source as? SettingsViewController {
            guard let inputTax = settingVC.taxTextField.text else { return }
            guard let inputPlan = settingVC.planTextField.text else { return }
            
            taxValueLabel.text = inputTax.isEmpty ? settingVC.currentTax : inputTax
            planValueLabel.text = inputPlan.isEmpty ? settingVC.currentPlan : inputPlan
        }
    }
}

//MARK: Check Validation
extension UIViewController {
    func isValid(text: String) -> Bool {
        let numberPattern = "^(0|[1-9][0-9]*)(\\.[0-9]+)?$"
        return NSPredicate(format: "SELF MATCHES %@", numberPattern)
            .evaluate(with: text)
    }
}

// MARK: Show Alert
extension UIViewController {
    func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okButton = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}

// MARK: Changing comma on dot
extension UIViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text?.replacingOccurrences(of: ",", with: ".")
    }
}
