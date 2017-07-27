import Foundation

enum Operation: String {
    case addition = "+"
    case subtraction = "-"
    case multiplication = "*"
    case division = "/"
}

class CalculatorBrain {

    // Shunting-yard algorithm variables
    private var outputQueue: [Character] = []
    private var operatorsStack: [Character] = []

    // Reverse Polish notation algorithm variables
    private var rpnStack: [String] = []

    func compute(_ expression: String) -> Double? {
        self.outputQueue = []
        self.operatorsStack = []
        self.rpnStack = []

        let equation = expression.mathEquation

        let postfix = self.parseInfix(equation)

        return self.computePostfix(postfix)
    }

    /** 
     *  Shunting-yard algorithm
     **/

    func parseInfix(_ expression: String) -> [Character] {
        for character in expression.characters {
            let str = "\(character)"
            if str.isNumber {
                self.outputQueue.append(character)
            } else if str.isOperator(from: "+-*/") {
                // add operator to stack or move to outputQueue
                self.updateOperatorsStack(with: character)
            }
        }

        return self.outputQueue + self.operatorsStack
    }

    private func updateOperatorsStack(with operator: Character) {
        if let top = self.operatorsStack.first {
            if self.precedence(of: top) >= self.precedence(of: `operator`) {
                self.outputQueue.append(self.operatorsStack.removeFirst())

                self.updateOperatorsStack(with: `operator`)
            } else {
                self.operatorsStack.insert(`operator`, at: 0)
            }
        } else {
            self.operatorsStack.insert(`operator`, at: 0)
        }
    }

    private func precedence(of operator: Character) -> Int {
        guard let operation = Operation(rawValue: "\(`operator`)") else { return 0 }

        switch operation {
        case .addition, .subtraction:       return 1
        case .multiplication, .division:    return 2
        }
    }

    /**
     *  Postfix algorithm
     **/

    func computePostfix(_ postfix: [Character]) -> Double? {
        for character in postfix {
            let str = "\(character)"
            if str.isNumber {
                self.rpnStack.append(str)
            } else if str.isOperator(from: "+-*/") && self.rpnStack.count > 1 {
                let right = Double(self.rpnStack.removeLast())
                let left = Double(self.rpnStack.removeLast())

                let tmp = self.makeAnOperation(str, left: left, right: right)
                self.rpnStack.append("\(tmp)")
            }
        }

        return self.rpnStack.count > 0 ? Double(self.rpnStack.removeLast()) : nil
    }

    private func makeAnOperation(_ operator: String, left: Double?, right: Double?) -> Double {
        guard let operation = Operation(rawValue: `operator`), let left = left, let right = right else { return 0 }

        switch operation {
        case .addition:         return left + right
        case .subtraction:      return left - right
        case .multiplication:   return left * right
        case .division:         return left / right
        }
    }
}
