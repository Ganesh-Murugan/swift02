indirect enum Calculation {
    case value(Int), add(Calculation, Calculation), subtract(Calculation, Calculation)
}

struct Calculator {
    func calculate(_ operation: Calculation) -> Int{
        switch operation {
        case let .value(value):
            return value
        case let .add(leftValue, rightValue):
            return calculate(leftValue) + calculate(rightValue)
        case let .subtract(leftValue, rightValue):
            return calculate(leftValue) - calculate(rightValue)
        }
    }
}
let calc = Calculator()
let result = calc.calculate(.add(.value(10), .value(10)))
let result2 = calc.calculate(.subtract(.value(result), .value(10)))
print(result)
print(result2)
