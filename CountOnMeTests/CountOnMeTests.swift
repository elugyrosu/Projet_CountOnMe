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
    
    func testGivenCalculIsNull_WhenAddOnePlusOneAndCalcul_ThenTotalIs2(){
        if calculator.expressionHaveResult {
            calculator.text = ""
        }
        calculator.text.append("1")
        
        if calculator.canAddOperator {
            calculator.text.append(" + ")
        }
        
        if calculator.expressionHaveResult {
            calculator.text = ""
        }
        calculator.text.append("1")
        
        
        XCTAssert(calculator.calculateTotal() == true)
        XCTAssert(calculator.text == "1 + 1 = 2")
        
        
    }
    
    
}

