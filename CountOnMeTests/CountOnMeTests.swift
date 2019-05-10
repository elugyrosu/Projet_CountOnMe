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
    
    func testGivenCalculIsNull_WhenAdd1x1_ThenTotalIsOne(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addMultiplication()
        calculator.text = calculator.addNumber(numberText: "1")
        
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "1 * 1 = 1")

    }
    
    func testGivenCalculIsNull_WhenAddComplexCalcul_ThenTotalIs(){
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
        
        
        XCTAssert(calculator.text == "2 + 10 / 93 - 5 * 3 / 6 = -0.39247322")
        
    }
    
    func testGivenCalculIsNull_WhenAddOnePlusPlus_ThenError(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addPlus()

        XCTAssert(calculator.text == "1 + ")

    }
    func testGivenCalculIsNull_WhenAddOnePlusMinus_ThenError(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addMinus()
        
        XCTAssert(calculator.text == "1 + ")

    }
    func testGivenCalculIsNull_WhenAddPlusMultiplication_ThenError(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addMultiplication()
        
        XCTAssert(calculator.text == "1 + ")
    }
    func testGivenCalculIsNull_WhenAddPlusDivision_ThenError(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addDivision()
        
        XCTAssert(calculator.text == "1 + ")
    }
    
    func testGivenCalculIsNull_WhenAddPlusAndCalcul_ThenError(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "1 + ")
    }
    
    
    func testGivenCalculIsNull_WhenCalcul_ThenError(){
        calculator.text = calculator.calculateTotal()
        XCTAssert(calculator.text == "")


    }
    
    func testGivenCalculOnePlusOne_WhenAddTwo_ThenTextIsTwo(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.calculateTotal()
        calculator.text = calculator.addNumber(numberText: "2")
        
        XCTAssert(calculator.text == "2")

    }

    func testGivenCalculIsOneDivisonByTwo_WWenCalculate_ThenTextIsResult(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addDivision()
        calculator.text = calculator.addNumber(numberText: "2")
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "1 / 2 = 0.5")

    }
    

    func testGivenCalculIsOne_WhenCalculate_ThenError(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "1")
        
        
    }
    func testGivenCalculIsOnePlusOne_WhenCalculateTwoTimesAndAddOne_ThenResetText(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addNumber(numberText: "1")
        
        
        calculator.text = calculator.calculateTotal()
        calculator.text = calculator.calculateTotal()
        calculator.text = calculator.addNumber(numberText: "1")
        
        
        XCTAssert(calculator.text == "1")
        
        
    }
    
    func testGivenMinusNinePlusOne_WhenCalculate_ThenTextIsReset(){
        calculator.text = calculator.addMinus()
        calculator.text = calculator.addNumber(numberText: "9")
        calculator.text = calculator.addPlus()
        calculator.text = calculator.addNumber(numberText: "1")
        
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "")
    }
    func testGivenDivisionByZero_WhenCalculate_ThenTextIsReset(){
        calculator.text = calculator.addNumber(numberText: "9")
        calculator.text = calculator.addDivision()
        calculator.text = calculator.addNumber(numberText: "0")
        
        calculator.text = calculator.calculateTotal()
        
        XCTAssert(calculator.text == "")
    }
    func testGivenOneDivisonAnd_WhenDivisionAgain_ThenContinueCalculWithoutDivision(){
        calculator.text = calculator.addNumber(numberText: "1")
        calculator.text = calculator.addDivision()
        
        calculator.text = calculator.addDivision()

  
        XCTAssert(calculator.text == "1 / ")
    }



}

