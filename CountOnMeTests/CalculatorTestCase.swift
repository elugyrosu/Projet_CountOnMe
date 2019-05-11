//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTestCase: XCTestCase {
    var calculator: Calculator!
    
    override func setUp(){ // called before all tests
        super.setUp()
        calculator = Calculator()
    }
    
    // MARK: Results test
    
    func testGivenCalculIsOneXsOnel_WhenCalculate_ThenTotalIs(){    // check Int conversion with multiplication
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addMultiplication()
        calculator.text = calculator.addNumber(numberText: "1")
        
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "1 * 1 = 1")
    }
    
    func testGivenCalculIsOneDivisonByTwo_WWenCalculate_ThenTextIsResult(){ // Check Division
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addDivision()
        calculator.text = calculator.addNumber(numberText: "2")
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "1 / 2 = 0.5")
    }
    
    func testGivenComplexCalculWithAllOperators_WhenCalculateTotal_ThenTotalIs(){   // Test priority (big test covering)
        calculator.text = calculator.addNumber(numberText: "2")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addNumber(numberText: "10")
        calculator.text = calculator.addDivision()
        calculator.text = calculator.addNumber(numberText: "93")
        calculator.text = calculator.addMinus()
        calculator.text = calculator.addNumber(numberText: "5")
        calculator.text = calculator.addMultiplication()
        calculator.text = calculator.addNumber(numberText: "3")
        calculator.text = calculator.addDivision()
        calculator.text = calculator.addNumber(numberText: "6")
        
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "2 + 10 / 93 - 5 * 3 / 6 = -0.39247311827957")
    }
    
    func testGivenCalculOnePlusOne_WhenAddTwo_ThenTextIsTwo(){  // Check if pass to new operation after total
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.calculateTotal()
        
        calculator.text = calculator.addNumber(numberText: "6")
        
        XCTAssert(calculator.text == "6")
    }
    
    
    // MARK: Operators errors
    
    func testGivenOperationIsOnePlus_WhenAddPlus_ThenNoTextChange(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        
        calculator.text = calculator.addPlus()
        
        XCTAssert(calculator.text == "1 + ")
    }
    func testGivenOperationIsOnePlus_WhenAddMinus_ThenNoTextChange(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        
        calculator.text = calculator.addMinus()
        
        XCTAssert(calculator.text == "1 + ")
    }
    func testGivenOperationIsOnePlus_WhenAddMultiplication_ThenNoTextChange(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        
        calculator.text = calculator.addMultiplication()
        
        XCTAssert(calculator.text == "1 + ")
    }
    func testGivenOperationIsOnePlus_WhenAddDivision_ThenNoTextChange(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        
        calculator.text = calculator.addDivision()
        
        XCTAssert(calculator.text == "1 + ")
    }
    
    // MARK: Calculs errors
    
    func testGivenOneDivisionZero_WhenCalculate_ThenTextIsReset(){   // Debug Division by zero
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addDivision()
        calculator.text = calculator.addNumber(numberText: "0")
        
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "")
    }
    
    func testGivenNoOperation_WhenCalculate_ThenNoTextChange(){  // Debug when is empty
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "")
    }
    
    func testGivenOne_WhenCalculate_ThenNoTextChange(){
        calculator.text = calculator.addNumber(numberText: "1")
        
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "1")
    }
    
    func testGivenOperationIsOnePlus_WhenCalculate_ThenNoTextNoChange(){   // Debug wrong operation
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "1 + ")
    }
    
    func testGivenCalculIsOnePlusOneAndCalculateTwoTimes_WhenAddSix_ThenTextIsSix(){    // Debug after operation calculate a second time
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.calculateTotal()
        calculator.text = calculator.calculateTotal()
        
        calculator.text = calculator.addNumber(numberText: "6")
        
        XCTAssert(calculator.text == "6")
    }
    
    func testGivenMinusNinePlusOne_WhenCalculate_ThenTextIsReset(){ // no operator at start possible. Debug and reset (only when you start the application)
        calculator.text = calculator.addMinus()
        calculator.text = calculator.addNumber(numberText: "9")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addNumber(numberText: "1")
        
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "")
    }
}

