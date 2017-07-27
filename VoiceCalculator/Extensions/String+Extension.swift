import Foundation

extension String {

    var isNumber: Bool {
        return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    func isOperator(from operators: String) -> Bool {
        var operatorsSet = CharacterSet.urlQueryAllowed
        operatorsSet.insert(charactersIn: operators)

        return !self.isEmpty && self.rangeOfCharacter(from: operatorsSet) != nil
    }

    var mathEquation: String {
        let mathCharacters = Set("0123456789+-×÷*/".characters)

        let equation = self.filterBy(mathCharacters)
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")

        return equation
    }

    func filterBy(_ set: Set<Character>) -> String {
        return String(self.characters.filter({ set.contains($0) }))
    }
}
