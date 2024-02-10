//
//  SettingsViewController.swift
//  Bus Calculator
//
//  Created by Denis Denisov on 10/2/24.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet var currentTaxValueLabel: UILabel!
    @IBOutlet var currentPlanValueLabel: UIStackView!
    
    @IBOutlet var taxTextField: UITextField!
    @IBOutlet var planTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taxTextField.becomeFirstResponder()
    }
}
