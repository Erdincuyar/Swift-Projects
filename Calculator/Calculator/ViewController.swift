//
//  ViewController.swift
//  Calculator
//
//  Created by Erdinç Uyar on 7.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNumber: UITextField!
    
    @IBOutlet weak var SecondNumber: UITextField!
    
    @IBOutlet weak var Result: UILabel!
    var result = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Sum(_ sender: Any) {
        if let firstText = Int(firstNumber.text!){
            if let SecondText = Int(SecondNumber.text!){
                
                let result = firstText + SecondText
                Result.text = String(result)
            }
        }
    }
    
    @IBAction func Sub(_ sender: Any) {
        if let firstText = Int(firstNumber.text!) {
            if let SecondText = Int(SecondNumber.text!) {
                
                let result = firstText - SecondText
                Result.text = String(result)
            }
        }
    }

    
    
    @IBAction func Multi(_ sender: Any) {
        if let firstText = Int(firstNumber.text!){
            if let SecondText = Int(SecondNumber.text!){
                
                let result = firstText * SecondText
                Result.text = String(result)
            }
        }
    }

    
    @IBAction func Divide(_ sender: Any) {
        if let firstText = Int(firstNumber.text!){
            if let SecondText = Int(SecondNumber.text!){
                
                let result = firstText / SecondText
                Result.text = String(result)
            }
        }
    }

    
    
}

