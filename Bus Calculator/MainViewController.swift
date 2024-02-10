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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text?.replacingOccurrences(of: ",", with: ".")
    }

    @IBAction func countButtonTapped() {
        guard let inputText = inputSumTF.text, !inputText.isEmpty else {
            showAlert(
                withTitle: "Ошибка",
                andMessage: "Поле ввода не может быть пустым"
            )
            return
        }
        
        do {
            let regex = try NSRegularExpression(pattern: "^(0|[1-9][0-9]*)(\\.[0-9]+)?$")
            let range = NSRange(location: 0, length: inputText.utf16.count)

            if regex.firstMatch(in: inputText, options: [], range: range) != nil {
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
            } else {
                showAlert(
                    withTitle: "Сумма введена некорректно",
                    andMessage: "После нуля должна идти точка, если это не целое число."
                )
            }
        } catch {
            showAlert(
                withTitle: "Ошибка",
                andMessage: "Произошла ошибка при обработке ввода. Пожалуйста, попробуйте снова."
            )
        }
    }
}

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
