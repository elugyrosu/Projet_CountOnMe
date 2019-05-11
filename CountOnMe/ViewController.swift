//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // No logic, just connections and alert protocol
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    let calculator = Calculator()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.displayAlertDelegate = self // Use alert protocol (run at start)
    }
    
    // MARK: View actions
    // Adapted for Model extraction, all logic moved to functions with string return
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        textView.text = calculator.addNumber(numberText: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        textView.text = calculator.addPlus()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        textView.text = calculator.addMinus()
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) { // add for multiplication
        textView.text = calculator.addMultiplication()
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) { // add for divison
        textView.text = calculator.addDivision()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        textView.text = calculator.calculateTotal()
    }
}

// MARK: - UIAlertController

extension ViewController: DisplayAlert { // use DisplayAlert protocol
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
