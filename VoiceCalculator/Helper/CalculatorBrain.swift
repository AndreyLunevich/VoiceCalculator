import Foundation

class CalculatorBrain {

    func result(of expression: String) -> Double? {
        let equation = expression.mathEquation

        var result: Double?

        TryCatchFinally.try({
            let expr = NSExpression(format: equation)

            result = expr.expressionValue(with: nil, context: nil) as? Double
        }, catch: nil, finally: nil)

        return result
    }
}
