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
       calculator.text = calculator.addNumber(numberText: "1")
       calculator.text = calculator.addPlus()
       calculator.text = calculator.addNumber(numberText: "1")
       calculator.text = calculator.calculateTotal()
        
        
        XCTAssert(calculator.text == "1 + 1 = 2.0")
        
        
    }
    
    
}

