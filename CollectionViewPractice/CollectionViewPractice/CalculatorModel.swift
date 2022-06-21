//
//  CalculatorModel.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//
enum Operators {
    case addition, multiplication, division, subtraction, mod, dot
}
enum cellType {
    case numeric, Operators
}

import Foundation

struct Calculator {
    var numbers: [Int] = [0,1,2,3,4,5,6,7,8,9]
    var operators = Operators.self
}
