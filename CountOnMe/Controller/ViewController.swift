//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Created by hicham on 08/02/2020.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // my instance variable
    var countOnMe: CountOnModel = CountOnModel()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = countOnMe.text
        
    }
    
    // View actions add Number
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText: String = sender.title(for: .normal) else {
            return
        }
        // will add the numbers in our text
        countOnMe.addNumber(numberText)
        textView.text = countOnMe.text
    }
    // the function that allows you to add the addition and the action that will trigger the event
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        do {
            try countOnMe.addOperator("+")
        } catch CountOnModel.ModelError.cannotAddOperator {
            alerteError(message: "Un opérateur est deja mis")
        } catch CountOnModel.ModelError.unknownOperator {
            alerteError(message: "Cette operateur n'est pas supporté dans cette application")
        }catch {
            
        }
        textView.text = countOnMe.text
    }
    
    // the function that allows you to add the Multiply and the action that will trigger the event
    @IBAction func tappedMultiply(_ sender: UIButton) {
        do {
            try countOnMe.addOperator("*")
        } catch CountOnModel.ModelError.cannotAddOperator {
            alerteError(message: "Un opérateur est deja mis")
        } catch CountOnModel.ModelError.unknownOperator {
            alerteError(message: "Cette operateur n'est pas supporté dans cette application")
        } catch {
            //alerteError(message: "Veuillez revenir a Zéro!....")
        }
        textView.text = countOnMe.text
    }
    
    // the function that allows you to add the divide and the action that will trigger the event
    @IBAction func tappedDivide(_ sender: UIButton) {
        do {
            try countOnMe.addOperator("/")
        } catch CountOnModel.ModelError.cannotAddOperator {
            alerteError(message: "Un opérateur est deja mis")
        } catch CountOnModel.ModelError.unknownOperator {
            alerteError(message: "Cette operateur n'est pas supporté dans cette application")
        } catch {
            
        }
        textView.text = countOnMe.text
    }
    
    
    //the function that allows you to add the subtraction and the action that will trigger the event
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        do {
            try countOnMe.addOperator("-")
        } catch CountOnModel.ModelError.cannotAddOperator {
            alerteError(message: "Un opérateur est deja mis")
        } catch CountOnModel.ModelError.unknownOperator {
            alerteError(message: "Cette operateur n'est pas supporté dans cette application")
        } catch {
            
        }
        textView.text = countOnMe.text
    }
    
    // reset the empty text area
    @IBAction func tappedClear(_ sender: UIButton) {
        countOnMe.reset()
        textView.text = countOnMe.text
        
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        do {
            try countOnMe.calculate()
            textView.text = countOnMe.text
        } catch CountOnModel.ModelError.expressionIncorrect {
            alerteError(message: "Entrez une expression correcte ! , pour démarrez un nouveau calcul")
        } catch {
            
        }
        
    }
    // method to write the error only once and call it and change our message for errors
    func alerteError(message: String) {
        let alert: UIAlertController = UIAlertController(title: "Zéro!", message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


