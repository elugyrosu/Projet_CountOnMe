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

    func refresh(){
        textView.text = calculator.text
    }

    func alertWithMessage(message: String){
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if calculator.expressionHaveResult {
            calculator.text = ""
        }
        calculator.text.append(numberText)
        refresh()
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            calculator.text.append(" + ")
            refresh()
        } else {
            alertWithMessage(message: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            calculator.text.append(" - ")
            refresh()
        } else {
            alertWithMessage(message: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else {
            return alertWithMessage(message: "Entrez une expression correcte !")
        }
        guard calculator.expressionHaveEnoughElement else {
            return alertWithMessage(message: "Démarrez un nouveau calcul !")
        }
        if calculator.calculTotal()  == false {
            return alertWithMessage(message: "Démarrez un nouveau calcul !")
        }else{
            refresh()
        }
    }
}
