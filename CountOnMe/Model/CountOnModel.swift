//
//  CountOnModel.swift
//  CountOnMe
//
//  Created by hicham on 08/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation


class CountOnModel {
    
    // the enumeration of the different error possible
    enum ModelError: Error {
        case cannotAddOperator
        case unknownOperator
        case notEnoughtElementToCompute
        case expressionIncorrect
        case divisionByZero
    }
    // this variable will be called in the View Controller
    var text = ""
    // private
    
    // sert a separer notre tableau de chaine de caractère
    private var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    
    // verification of these variables and which returns a boolean
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" &&  elements.last != "/" && elements.last != "*"
    }
    private var expressionHaveResult: Bool {
        return elements.contains("=")
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    //
    var result: String? {
        let split = text.split(separator: "=")
        guard var last = split.last, split.count > 1 else {
            return nil
        }
        last.removeFirst()
        return String(last)
    }
    
    // it is a method which makes it possible to see if the operator is known
    private func isKnownOperator(_ ope: String) -> Bool {
        return ope == "+" || ope == "-" ||  ope == "*" || ope == "/"
    }
    
    // checks that the operation contains an equal
    func addNumber(_ num: String)  {
        if expressionHaveResult {
            text = ""
        }
        text += num
    }
    
    // method which will be called when the clear button is pressed
    func reset(){
        text = ""
        
    }
    
    
    func addOperator(_ ope: String) throws {
        
        if expressionHaveResult {
            text = result!
        }
        guard canAddOperator else {
            throw ModelError.cannotAddOperator
        }
        guard isKnownOperator(ope) else {
            throw ModelError.unknownOperator
        }
        text += " \(ope) "
    }
    
    // this method is the most important, it will manage the calculations
    func calculate() throws{
        
        // MARK: - Property
        var operationsToReduce = elements
        guard expressionHaveEnoughElement else {
            throw ModelError.notEnoughtElementToCompute
        }
        guard expressionIsCorrect else {
            throw ModelError.expressionIncorrect
        }
        
        operationsToReduce = try reduceComplexCalcul(operationsToReduce)
        operationsToReduce = reduceCalcul(operationsToReduce)
        
        text += " = \(operationsToReduce.first!)"
    }
    
    //function that will manage addition and subtraction
    // they do not have priority during a calculation
    func reduceCalcul(_ operat: [String]) -> [String] {
        var operationsToReduce = operat
        while operationsToReduce.count > 1 {
            
            
            if let index = operationsToReduce.firstIndex(where: {$0 == "+" || $0 == "-"}), let left = Float(operationsToReduce[index - 1]), let right = Float(operationsToReduce[index + 1]) {
                let operand = operationsToReduce[index]
                var result: Double
                
                // lire l'operateur
                if operand == "+" {
                    result = Double(left + right)
                } else {
                    result = Double(left - right)
                }
                
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert(String(format: "%.2f", result), at: 0)
            }
        }
        return operationsToReduce
    }
    
    // function that will manage the priorities of the calculations
    private func reduceComplexCalcul(_ oper: [String]) throws -> [String] {
        var operationsToReduce = oper
        // priorite de calcul  (multiply and divide)
        while operationsToReduce.contains("*") || operationsToReduce.contains("/") {
            if let index = operationsToReduce.firstIndex(where: {$0 == "*" || $0 == "/"}), let left = Double(operationsToReduce[index - 1]), let right = Double(operationsToReduce[index + 1]) {
                var result: Double
                let operand = operationsToReduce[index]
                
                // read the operator
                if operand == "*" {
                    result = Double(left * right)
                } else {
                    if right == 0 {
                        throw ModelError.divisionByZero
                    }
                    result = Double(left / right)
                }
                operationsToReduce[index - 1] = String(format: "%.2f", result)
                operationsToReduce.remove(at: index + 1 )
                operationsToReduce.remove(at: index)
            }
        }
        return operationsToReduce
    }
}
