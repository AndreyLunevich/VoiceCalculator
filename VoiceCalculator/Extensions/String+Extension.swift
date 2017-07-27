extension String {

    var mathEquation: String {
        let mathCharacters = Set("0123456789+-×÷".characters)

        let equation = self.filterBy(mathCharacters)
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")

        return equation
    }

    func filterBy(_ set: Set<Character>) -> String {
        return String(self.characters.filter({ set.contains($0) }))
    }
}
