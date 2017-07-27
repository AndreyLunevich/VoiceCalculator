import Foundation

class CalculatorBrain {

    func result(of expression: String) -> String? {
        let equation = expression.mathEquation

        var result: Double?

        TryCatchFinally.try({
            let expr = NSExpression(format: equation)

            result = expr.expressionValue(with: nil, context: nil) as? Double
        }, catch: nil, finally: nil)

        guard let res = result else { return nil }

        return String(format: "%g", res)
    }
}
