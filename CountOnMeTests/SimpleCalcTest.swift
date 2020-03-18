//
//  SimpleCalcTest.swift
//  CountOnMeTests
//
//  Created by hicham on 27/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.

import XCTest
@testable import CountOnMe
class SimpleCalcTest: XCTestCase {
    
    var countOnMe:CountOnModel!
    
    override func setUp() {
        countOnMe = CountOnModel()
        
    }
    // Four Operator Test
    // Test Addition
    func testGivenNumbersAre2And1_WhenAdd_ThenResultIs3() {
        do {
            countOnMe.addNumber("2")
            try countOnMe.addOperator("+")
            countOnMe.addNumber("1")
            try countOnMe.calculate()
            XCTAssert(countOnMe.result == "3.00")
        } catch {
            XCTAssert(false)
        }
    }
    // Test substraction
    func testGivenNumbersAre2And1_WhenSubstract_ThenResultIs1() {
        do {
            countOnMe.addNumber("2")
            try countOnMe.addOperator("-")
            countOnMe.addNumber("1")
            try countOnMe.calculate()
            XCTAssert(countOnMe.result == "1.00")
        } catch {
            XCTAssert(false)
        }
    }
    // Test division
    func testGivenNumbersAre2And1_WhenDivide_ThenResultIs2() {
        do {
            countOnMe.addNumber("2")
            try countOnMe.addOperator("/")
            countOnMe.addNumber("1")
            try countOnMe.calculate()
            
            XCTAssert(countOnMe.result == "2.00")
        } catch {
            XCTAssert(false)
        }
    }
    // Test Multiplication
    func testGivenNumbersAre3And3_WhenMultiply_ThenResultIs9() {
        do {
            countOnMe.addNumber("3")
            try countOnMe.addOperator("*")
            countOnMe.addNumber("3")
            try countOnMe.calculate()
            
            XCTAssert(countOnMe.result == "9.00")
        } catch {
            XCTAssert(false)
        }
    }
    // Test - Button Clear
    func testGivenClearTextView_WhenTappedClear_ThenItClear() {
        
        countOnMe.addNumber("3")
        countOnMe.reset()
        XCTAssert(countOnMe.text.isEmpty)
        
    }
    
    // test priority calcul (43 + 70 - 24 * 57 / 10)
    func testGivenCalculAllOperators_WhenTappedEqualButton_ThenResultIsOk() {
        
        do{   countOnMe.addNumber("43")
            try countOnMe.addOperator("+")
            
            countOnMe.addNumber("70")
            
            try countOnMe.addOperator("-")
            countOnMe.addNumber("24")
            try countOnMe.addOperator("*")
            countOnMe.addNumber("57")
            try countOnMe.addOperator("/")
            countOnMe.addNumber("10")
            try countOnMe.calculate()
            XCTAssertTrue(countOnMe.result == "-23.80")
        }catch {
            XCTAssert(false)
        }
    }
    // Error tapped 2 operators , tapped 1 + /
    func testGivenCalculWith2OperandSucccessive_WhenExpressionHaveEnoughElements_ThenMessageError() {
        do {
            countOnMe.addNumber("1")
            try countOnMe.addOperator("+")
            try countOnMe.addOperator("/")
            _ = try countOnMe.calculate()
            XCTAssert(false)
        } catch CountOnModel.ModelError.cannotAddOperator {
            XCTAssertTrue(true)
        } catch {
            XCTAssert(false)
        }
    }
    // Start with an operator and it is an error
    // raise the exception when there is no number
    func testGivenCalculWithOperatorAtFirst_WhenLastTappedOperators_theMessageReturnsFalse() {
        do {
            
            try countOnMe.addOperator("/")
            try countOnMe.calculate()
            XCTAssert(false)
        }  catch CountOnModel.ModelError.unknownOperator {
            XCTAssertFalse(false)
        }catch {
            XCTAssert(true)
        }
    }
    
    //test divide By Zero
    func testGivenOperationString_WhenDivisionByZeroAndcountOnMePriorities_ThenHaveAnError() {
        do {
            countOnMe.addNumber("10")
            try countOnMe.addOperator("/")
            countOnMe.addNumber("0")
            try countOnMe.calculate()
            XCTAssert(false)
        }catch {
            XCTAssert(true)
        }
    }
    // Make a test with a calculation that ends with an operator
    func testFinishOperator_WhenTestingExpressionHaveResult_ThenExpressionIncorrect(){
        
        do {
            countOnMe.addNumber("1")
            try countOnMe.addOperator("+")
            XCTAssertThrowsError(try countOnMe.addOperator("/"))
        } catch {
            
        }
    }
    // test without operator
    func testKnowOperateur_WhenOperator_ThenUnKnowOperator () {
        do{
            try countOnMe.addOperator("1")
            XCTAssert(false)
        }catch CountOnModel.ModelError.unknownOperator {
            XCTAssert(true)
        }catch {
            XCTAssert(false)
        }
    }
    // test which verifies that when a number is pressed after displaying a result, only the number remains
    func testAddNumber_WhenAddNumberAndResult_ThenResult(){
        do {
            countOnMe.addNumber("10")
            try countOnMe.addOperator("+")
            countOnMe.addNumber("10")
            try countOnMe.calculate()
            countOnMe.addNumber("34")
            
            XCTAssert(countOnMe.text == "34")
            
        }catch {
            XCTAssert(false)
        }
        
    }
    
    //test which verifies that when you enter an operator, after having displayed a result, the previous result is kept and the operator is added
    func testAddNumber_WhenAddNumberAndResultAndOperator_ThenResult(){
        do {
            countOnMe.addNumber("10")
            try countOnMe.addOperator("+")
            countOnMe.addNumber("10")
            try countOnMe.calculate()
            try countOnMe.addOperator("+")
            print(countOnMe.text)
            XCTAssert(countOnMe.text == "20.00 + ")
        }catch {
            XCTAssert(false)
        }
    }
    
    // test which ends with an operator
    func testAddCalcul_WhenAddOperator_ThenExpressionIncorrect(){
        do {
            countOnMe.addNumber("10")
            try countOnMe.addOperator("+")
            countOnMe.addNumber("10")
            try countOnMe.addOperator("+")
            try countOnMe.calculate()
        }catch CountOnModel.ModelError.expressionIncorrect {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    // test without calculating
    func testAddCalul_WhenWithoutCalculation_ThenResultNil(){
        do {
            countOnMe.addNumber("10")
            try countOnMe.addOperator("+")
            countOnMe.addNumber("10")
            try countOnMe.addOperator("+")
            XCTAssertNil(countOnMe.result)
        } catch {
            XCTAssert(false)
        }
        
    }
    
}
