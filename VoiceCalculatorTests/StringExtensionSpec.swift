import Quick
import Nimble
@testable import VoiceCalculator

class StringExtensionSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {

        context("filter of string to symbols of math equation") {

            it("One+1*3") {
                let filtered = "One+1*3".mathEquation

                expect(filtered).to(equal("+1*3"))
            }

            it("One+1÷3") {
                let filtered = "One+1÷3".mathEquation

                expect(filtered).to(equal("+1/3"))
            }
        }
    }
}
