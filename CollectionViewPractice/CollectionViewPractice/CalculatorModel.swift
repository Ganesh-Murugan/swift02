//
//  CalculatorModel.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//
import Foundation

enum Operators: String, CaseIterable {
    case addition = "+", multiplication = "*", division = "/", subtraction = "-", mod = "%", dot = ".", equal = "=", clear = "c"
}
enum cellType {
    case numeric, Operations(_ operators: Operators)
}

struct Calculator {
    var value: String
    var type: cellType
}

struct CalculatorCells {
    var values = [Calculator(value: "c", type: .Operations(.clear)),
                  Calculator(value: "=", type: .Operations(.equal)),
                  Calculator(value: "/", type: .Operations(.division)),
                  Calculator(value: "-", type: .Operations(.mod)),
                  Calculator(value: "1", type: .numeric),
                  Calculator(value: "2", type: .numeric),
                  Calculator(value: "3", type: .numeric),
                  Calculator(value: "*", type: .Operations(.multiplication)),
                  Calculator(value: "4", type: .numeric),
                  Calculator(value: "5", type: .numeric),
                  Calculator(value: "6", type: .numeric),
                  Calculator(value: "+", type: .Operations(.addition)),
                  Calculator(value: "7", type: .numeric),
                  Calculator(value: "8", type: .numeric),
                  Calculator(value: "9", type: .numeric),
                  Calculator(value: "0", type: .numeric),
                  ]
}
