//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    let calculator = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.displayAlertDelegate = self
        // Do any additional setup after loading the view.
    }
    
    // View actions
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
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        textView.text = calculator.addMultiplication()
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        textView.text = calculator.addDivision()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        textView.text = calculator.calculate()
    }


}

extension ViewController: DisplayAlert {
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
