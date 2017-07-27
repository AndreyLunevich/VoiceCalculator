import Quick
import Nimble
@testable import VoiceCalculator

class CalculatorBrainSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {

        var brain: CalculatorBrain?

        beforeEach {
            brain = CalculatorBrain()
        }

        context("parse math expression to postfix") {

            it("1+3*2") {
                let postfix = brain?.parseInfix("1+3*2")

                expect(postfix).to(equal(["1", "3", "2", "*", "+"]))
            }

            it("1+3*2-4") {
                let postfix = brain?.parseInfix("1+3*2-4")

                expect(postfix).to(equal(["1", "3", "2", "*", "+", "4", "-"]))
            }

            it("+1") {
                let postfix = brain?.parseInfix("+1")

                expect(postfix).to(equal(["1", "+"]))
            }

            it("3+4*2/3") {
                let postfix = brain?.parseInfix("3+4*2/3")

                expect(postfix).to(equal(["3", "4", "2", "*", "3", "/", "+"]))
            }
        }

        context("compute postfix expression") {

            it("1+3*2") {
                let result = brain?.computePostfix(["1", "3", "2", "*", "+"])

                expect(result).to(equal(7))
            }

            it("3+4*2/3") {
                let result = brain?.computePostfix(["3", "4", "2", "*", "3", "/", "+"])

                expect(result).to(beCloseTo(5.6667, within: 0.1))
            }
        }

        context("compute recognized expression") {

            it("One+1÷3") {
                let result = brain?.compute("One+1÷3")

                expect(result).to(beCloseTo(0.33, within: 0.1))
            }

            it("Seven+1+4/3") {
                let result = brain?.compute("Seven+1+4/3")

                expect(result).to(beCloseTo(2.33, within: 0.1))
            }
        }
    }
}
