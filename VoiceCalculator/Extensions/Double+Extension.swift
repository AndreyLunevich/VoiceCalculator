import Foundation

extension Double {

    var asWord: String {
        let number = NSNumber(value: self)

        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut

        return formatter.string(from: number) ?? ""
    }
}
